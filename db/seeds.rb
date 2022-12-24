require 'uri'
require 'json'
require 'net/http'

# Dog.destroy_all

def fetch_ids(url)
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  request = Net::HTTP::Post.new(url)
  request['Content-Type'] = 'application/vnd.api+json'
  request['Authorization'] = ENV.fetch('RESCUEGROUPS_KEY')
  request.body = JSON.dump({
                             'data': {
                               'filterRadius': {
                                 'miles': 245,
                                 'coordinates': '45.508888,-73.561668'
                               }
                             }
                           })
  response = https.request(request)
  dogs_json = JSON.parse(response.body)
  dogs_json['data']
end

dogs = fetch_ids(URI("https://api.rescuegroups.org/v5/public/animals/search/available/dogs/haspic?limit=250&sort=animals.distance"))

dog_ids = []

dogs.map do |dog|
  dog_ids << dog['id']
end

dog_ids.each do |id|
  url = URI("https://api.rescuegroups.org/v5/public/animals/#{id}")
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Get.new(url)
  request['Content-Type'] = 'application/vnd.api+json'
  request['Authorization'] = ENV.fetch('RESCUEGROUPS_KEY')
  request.body = JSON.dump({
                             'data': {
                               'filterRadius': {
                                 'miles': 245,
                                 'coordinates': '45.508888,-73.561668'
                               }
                             }
                           })
  response = https.request(request)
  dogs_json = JSON.parse(response.body)

  next if dogs_json['included'][4].nil?

  pic = ''
  dogs_json['included'].each do |hash|
    pic = hash['attributes']['original']['url'] if hash['type'] == 'pictures'
  end

  # pp dogs_json['data'][0]['attributes']['ageGroup']
  attributes = { age_group: dogs_json['data'][0]['attributes']['ageGroup'],
                 age: dogs_json['data'][0]['attributes']['ageString'],
                 breed: dogs_json['data'][0]['attributes']['breedString'],
                 name: dogs_json['data'][0]['attributes']['name'],
                 sex: dogs_json['data'][0]['attributes']['sex'],
                 url: dogs_json['data'][0]['attributes']['url'],
                 latitude: dogs_json['included'][4]['attributes']['lat'],
                 longitude: dogs_json['included'][4]['attributes']['lon'],
                 picture: pic,
                 description: dogs_json['data'][0]['attributes']['descriptionHtml'] }
  Dog.create!(attributes)
end

puts 'Done'
