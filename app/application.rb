class Application

  def call(env)
      resp = Rack::Response.new
      req = Rack::Request.new(env)

      if req.path.match("/items/")
        item_name = req.path.split("/items/").last
          if item_search = @@items.find { |item| item.name == item_name }
            resp.write "#{item_search.price}"
          else
            resp.write "Item not found"
            resp.status = 400
          end
      else
        resp.status = 404
        resp.write "Route not found"
      end
      resp.finish
  end

end
