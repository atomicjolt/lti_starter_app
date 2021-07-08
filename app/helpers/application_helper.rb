module ApplicationHelper

  def application_base_url
    File.join(request.base_url, "/")
  end
  
end
