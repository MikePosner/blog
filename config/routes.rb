Rails.application.routes.draw do
  #设置当访问 http://localhost:3000/welcome/index 时,交给 welcome 控制器中的 index 动作处理
  get 'welcome/index'
  #嵌套路由用于声明在articles资源中中包含关联资源comments的访问方式
  #更简单的写法resources :articles, :has_many => :comments
  resources :articles do
    resources :comments
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #用于设置当访问程序的根路径时由控制器welcome的index动作去处理
  root 'welcome#index'
end
