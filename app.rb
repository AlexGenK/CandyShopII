#encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# обявление БД
set :database, "sqlite3:candyshop.db"

# Сущность/таблица - клиент
class Client < ActiveRecord::Base
end

# Сущность/таблица - конфетка
class Candy < ActiveRecord::Base
end

# Сущность/таблица - контакт
class Contact < ActiveRecord::Base
end

# процедура инициализации
configure do
	# список конфеток
	$candies=Candy.order "candyname"
end

# главная страница
get '/' do
	erb :index
end

# запись
get '/visit' do
	erb :visit
end

# отправка сообщений
get '/contacts' do
	erb :contacts
end

# 3
get '/three' do
	erb "<h3> Three </h3>"
end

# обработка записи
post '/visit' do

	# переменные содержащие значения полей ввода
	@username=params[:username]
	@phone=params[:phone]
	@data=params[:data]
	@candy=params[:candy]
	@colorpicker=params[:colorpicker]

	Client.create :name => @username, 
  				  :phone => @phone,
  				  :date => @data,
  				  :candy => @candy,
  				  :color => @colorpicker

	erb "<h3>Success! We wait you</h3>"

end

post '/contacts' do

	# переменные содержащие значения полей ввода
	@email=params[:email]
	@message=params[:message]

	Contact.create :email => @email, 
				   :message => @message
	
	erb "<h3>Thank You! Your message will be reviewed in the near future.</h3>"

end


# возвращает сообщение о возможных ошибках. принмимает хеш с парой
# имя_параметра=>выводимое сообщение. если параметр пустой, формируется сообщение
def get_error_message(hh)
	err=""
	hh.each_key {|param| err+=hh[param] if params[param].strip==""}
	return err
end
