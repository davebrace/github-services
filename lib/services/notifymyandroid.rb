class Service::NMA < Service
  string :apikey
  self.title = 'Notify My Android'

  def receive_push
    return unless payload['commits']

    url = URI.parse('https://www.notifymyandroid.com/publicapi/notify')
    repository = payload['repository']['url'].split("/")
    event = [repository[-2], repository[-1]].join('/')
    application = "GitHub"
    description = "#{payload['commits'].length} commits pushed to #{application} (#{payload['commits'][-1]['id'][0..7]}..#{payload['commits'][0]['id'][0..7]})

  Latest Commit by #{payload['commits'][-1]['author']['name']}
  #{payload['commits'][-1]['id'][0..7]} #{payload['commits'][-1]['message']}"

    http_post 'https://www.notifymyandroid.com/publicapi/notify',
      :apikey => data['apikey'],
      :application => application,
      :event => event,
      :description => description,
      :url => payload['compare']
  end
end
