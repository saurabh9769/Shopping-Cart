RailsAdmin.config do |config|

  ### Popular gems integration

  ## == Devise ==
  # config.authenticate_with do
  #   warden.authenticate! scope: :user
  # end
  # config.current_user_method(&:current_user)

  ## == Cancan ==
  # config.authorize_with :cancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    config.authenticate_with do
      authenticate_admin!
    end

    config.current_user_method(&:current_admin)

    ## With an audit adapter, you can add:
    # history_index
    # history_show
    config.model Category do
      list do
        field :id
        field :name
        field :created_by
        field :parent_id do
          formatted_value do
            bindings[:object].category.name if bindings[:object].parent_id != nil
          end
        end
        field :status
        field :modify_by
        exclude_fields :created_at
        exclude_fields :updated_at
      end
    end
    config.model Order do
      list do
        field :id
        field :user_id do
          formatted_value do
            bindings[:object].user.email
          end
        end
        field :billing_address_id
        field :shipping_address_id
        field :status
        field :grand_total
        field :shipping_charges
        field :coupon_id
      end
      if Rails.env.development?
        config.navigation_static_links = {
          'View Reports' => 'http://localhost:3000/orders'
        }
      elsif Rails.env.production?
        config.navigation_static_links = {
          'View Reports' => 'https://shopoholics.herokuapp.com/orders'
        }
      end
    end
    config.model Product do
      list do
        field :id
        field :name
        field :price
        field :status
        field :category_id
      end

    end
  end
end
