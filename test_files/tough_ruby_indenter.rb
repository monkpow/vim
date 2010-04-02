module SolrHelper
	# grab a set of hotels matching the user query
	# peel off hotel ids, and get associated reviews
	# merge the two, and map to view model
	# Initial version contains too much functionality.  We'll trim down in later version
	
	def simple_query (query, qt='rails_standard')
		ActsAsSolr::Post.execute(Solr::Request::Standard.new(:query => query, :qt => qt)).data
	end
	
	def resolve_solr_query(query)
		tmp_result=get_hotels(query)
		decorate(tmp_result[:hotels], tmp_result[:reviews]) unless tmp_result.nil?
	end
	
	def get_hotels(query)
		hotels= simple_query("review_t:#{query}", 'rails_standard')
		hotel_ids= hotels['response']['docs'].map do |record| record['hotel.id_i'] end
		return nil if hotel_ids.empty?
		reviews=get_reviews(query,hotel_ids)
		return {
			:hotels => hotels,
			:reviews => reviews
		}
	end
	
	def get_reviews(query, hotel_ids)
		review_query = hotel_ids.map do |item| "hotel.id_i:#{item}" end
		review_query_string="( #{review_query.join(" ")} )"
		solr_data= simple_query("#{review_query_string}",'rails_reviews' )
	end
	
	def decorate(hotels, reviews)
		results = {
			:docs => hotels['response']['docs'].collect { |hotel|
				this_hotels_reviews = reviews['response']['docs'].find_all { |review| 
					review['hotel.id_i'] == hotel['hotel.id_i'] 
				}
				puts ">: #{this_hotels_reviews} | | #{hotel['hotel.id_i']}"
				{
					:hotel           => {
						:address_line_1  => hotel['address1_t'],
						:amenities       => hotel['amenity_facet'],
						:city            => hotel['city_facet'],
						:country         => hotel['country_facet'],
						:description     => hotel['description_t'],
						:name            => hotel['hotelname_t'],
						:orbitz_hotel_id => hotel['hotel.id_i'],
						:stars           => hotel['rating_t'],
						:state_province  => hotel['stateregion_facet'],
						:id              => hotel['hotel.id_i']
					},
					:reviews                 => this_hotels_reviews.collect { |review|
						{
							:reviewer => review['reviewer_t'] || "handsome pete",
							:comment  => review['comment_t'],
							:title    => review['title_t']
						}
					},
					:highlighted_comments    => hotels['highlighting'][hotel['id']].collect do |field| 
						field[1].collect do |comment| comment.strip end
					end,
					:total_number_of_reviews => hotel['review_t'].size,
					:average_user_rating     => hotel['rating_t']
				}
			},
			:facets => hotels['facet_counts']['facet_fields'],
			:numFound => hotels['response']['numFound'].to_i
		}
	end
	
end
