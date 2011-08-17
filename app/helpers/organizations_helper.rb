module OrganizationsHelper
  
  def unlink_org(view, oprofile)
    if view =="linked"
      link_to_remote " Unlink ", :url => {:controller=> "oprofiles", :action => "remove", :id => oprofile.id}
    end
  end
  
  def link_org(view, oprofile)
    if view =="unlinked"
      link_to_remote " Link ", :url => {:controller=> "oprofiles", :action => "add", :id => oprofile.id} 
    end
  end
  
  def edit_org(oprofile)
    if current_user and (current_user.account == oprofile.owner or current_user.account == oprofile.custodian)
     link_to " Edit ", edit_oprofile_path(oprofile.id)
    end
  end
  
  def show_org(oprofile)
   link_to " Show ", oprofile_path(oprofile.id)
  end
  
  def delete_org(oprofile)
    if (current_user.account == oprofile.owner or current_user.account == oprofile.custodian) and current_user.account.programs.first != oprofile
      link_to ' Destroy ', oprofile, :confirm => 'Are you sure?', :method => :delete 
    end
  end
  
  def claim(profile)
    if !profile.owner.nil? and !profile.owner.code.nil?
      "<input class=' claim' type='text' value='" + root_url + "organizations/claim/" + profile.id.to_s + "'>"
    end
  end
  
  def code(current_user, profile)
    if profile.custodian == current_user.account
      profile.owner.code
    end
  end
  
  def can_claim_org(profile)
    if profile.owner.code != "" and !profile.owner.code.nil?
      link_to "Claim this organization >>", root_url + "organizations/claim/" + profile.id.to_s
    end
  end
end
