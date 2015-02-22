module SocialsHelper
  def socials_list
    socials = Social.order(:order).where(:status => true).all

    render partial: 'socials/socials', locals: {socials: socials}
  end
end
