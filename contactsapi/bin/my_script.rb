require 'addressable/uri'
require 'rest-client'

def gen_url(addon = "")
  Addressable::URI.new(
  scheme: 'http',
  host: 'localhost',
  ``
  port: 3000,
  path: "/users#{addon}"
  ).to_s
end

def create_user
  url = gen_url

  puts RestClient.post(
  url,
  { user: { name: "Gizmo", email: "gizmo@gizmo.gizmo" } }
  )
end

def update_user
  url = gen_url("/3")

  puts RestClient.put(
  url,
  { user: { name: "Jubes", email: "thejubes@hotman.com"} }
  )

end
