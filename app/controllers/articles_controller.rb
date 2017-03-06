#控制器就是一个类，继承自 ApplicationController
class ArticlesController < ApplicationController
  #对用户进行身份验证也就是说除了 index 和 show 动作，其他动作都要通过身份验证才能访问
  #也就是说增删改查中除了查之外其他操作都是要在通过身份验证之后才可以完成
  http_basic_authenticate_with name: "233", password: "666", except: [:index, :show]
   #定义new动作
   #.new ：只是在内存中新建一个对象
   def new
    @article = Article.new
   end
   
   def create
     @article = Article.new(article_params)
     #@article.save 的作用是把模型保存到数据库中
	 #if用于判断数据是否通过了数据验证
     if @article.save
       redirect_to @article
     else
	   #如果保存失败,即数据没有通过数据验证,则再次显示新建文章页面
	   #render方法用于将保存失败的@article实例对象传给new动作的视图
	   #render和render_to的区别在于render_to会使浏览器重新发起请求也就意味着@article中的数据将被清空
       render 'new'
   end
  end
  
  def show
    #传入的参数 params[:id] 会从请求中获取 :id 参数 
	#把文章对象存储在一个实例变量中(以 @ 开头的变量),只有这样，变量才能在视图中使用。ruby中实例变量以@开头
    @article = Article.find(params[:id])
  end
  
  def index
    #显示所有文章
    @articles = Article.all
  end
  
  def edit
    #通过id找到具体的文章并将具体的数据赋给实例变量@article
    @article = Article.find(params[:id])
  end
  
  def update
    @article = Article.find(params[:id])
 
    if @article.update(article_params)
      redirect_to @article
    else
      render 'edit'
    end
  end
  
  def destroy
    @article = Article.find(params[:id])
    @article.destroy
 
    redirect_to articles_path
  end
  #在 Ruby 中,方法分为 public、private 和 protected 三种,只有 public 方法才能作为控制器的动作。
  #默认情况下关键字private下面的所有方法等都为私有
  private
    def article_params
      params.require(:article).permit(:title, :text)
    end
  
end
