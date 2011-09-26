Newsly::Engine.routes.draw do

	resources :newsletters do
		member do
			put 'send_test'
			put 'deliver'
		end
	end

	resources :templates do
		member do
			put	'send_test'
			put 'publish'
		end
	end

	match '/snippets' => 'snippets#index'

  get '/' => "newsletters#index"
end
