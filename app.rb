#encoding: utf-8
require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/activerecord'

# обявление БД
set :database, "sqlite3:candyshop.db"

# Сущность/таблица/модель - клиент
class Client < ActiveRecord::Base
	# валидация полей таблицы
	validates :name, :phone, :date, presence: true
	validates :phone, format: {with: /\A[\d() +-]{5,}\z/, message: "is incorrect."}
	validates :name, length: {minimum: 2}
end

# Сущность/таблица/модель - конфетка
class Candy < ActiveRecord::Base
end

# Сущность/таблица/модель - контакт
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
	$c=Client.new
	erb :visit
end

# отправка сообщений
get '/contacts' do
	erb :contacts
end

# список записавшихся
get '/visitlist' do
	@visit=Client.order "date"
	erb :visitlist
end

# личные страницы конфеток
get '/candy/:id' do
	@candy=Candy.find(params[:id])
	erb :candy
end

# обработка записи
post '/visit' do

	# создание нового объекта в таблице с введенными параметрами
	$c=Client.new params[:aaa]

	# запись нового объекта. если запись неуспешна, т.е. не прошла валидация,
	# выводится сообщение об ошибке
	if $c.save
		erb "<h3>Success! We wait you</h3>"
	else
		@error=$c.errors.full_messages.first
		erb :visit
	end

end

# обработка отправки сообщений
post '/contacts' do

	c=Contact.new params[:aaa]
	c.save
	
	erb "<h3>Thank You! Your message will be reviewed in the near future.</h3>"

end