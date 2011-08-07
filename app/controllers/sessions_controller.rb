class SessionsController < Clearance::SessionsController
 
  def destroy
    sign_out
    flash_success_after_destroy
    redirect_to(root_url)
  end
end