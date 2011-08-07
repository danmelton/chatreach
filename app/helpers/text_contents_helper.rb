module TextContentsHelper
  
  def unlink_txt(view, text_content)
    if view =="linked"
      link_to_remote " Unpublish ", :url => {:controller=> "text_contents", :action => "remove", :id => text_content.id}
    end
  end
  
  def link_txt(view, text_content)
    if view =="unlinked"
      link_to_remote " Add ", :url => {:controller=> "text_contents", :action => "add", :id => text_content.id} 
    end
  end
  
  def edit_txt(text_content)
    if current_user == text_content.user
     link_to " Edit ", edit_text_content_path(text_content)
    end
  end
  
  def delete_txt(text_content)
    if current_user == text_content.user
      link_to ' Destroy ', text_content, :confirm => 'Are you sure?', :method => :delete 
    end
  end
    
end
