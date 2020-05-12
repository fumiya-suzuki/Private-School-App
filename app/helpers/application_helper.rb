module ApplicationHelper
  
  # ページごとにタイトルを返す
  def full_title(page_name = "")
    base_title = "寺子屋SUZUKI"
    if page_name.empty?
      base_title
    else
      page_name + " | " + base_title
    end
  end
end
