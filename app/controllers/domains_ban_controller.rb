# typed: false

class DomainsBanController < DomainsController
  before_action :find_or_initialize_domain

  def update
    if domain_params[:banned_reason].present?
      if @domain.banned?
        @domain.unban_by_user_for_reason!(@user, domain_params[:banned_reason])
      else
        @domain.ban_by_user_for_reason!(@user, domain_params[:banned_reason])
      end
      flash[:success] = "Domain updated."
      redirect_to domain_path(@domain)
    else
      flash.now[:error] = "Reason required for the modlog."
      render :edit
    end
  end
end
