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

# 2
get '/two' do
	erb "<h2> Two </h2>"
end

# 3
get '/three' do
	erb "<h2> Three </h2>"
end

# обработка записи
post '/visit' do

	# переменные содержащие значения полей ввода
	@username=params[:username]
	@phone=params[:phone]
	@data=params[:data]
	@candy=params[:candy]
	@colorpicker=params[:colorpicker]

	erb :visit

end


# возвращает сообщение о возможных ошибках. принмимает хеш с парой
# имя_параметра=>выводимое сообщение. если параметр пустой, формируется сообщение
def get_error_message(hh)
	err=""
	hh.each_key {|param| err+=hh[param] if params[param].strip==""}
	return err
end
