---
marp: false
---

# День 1

---

## Цель курса

---

## Что вы узнаете

---

## Для кого этот курс

---

## Структура курса

* 3 вебинара по 2 часа
* теория + live coding
* домашние задания

---

## Инструменты

* RSpec
* FactoryBot
* SimpleCov
* DatabaseCleaner
* Capybara + Selenium

---

## Как добиться успеха?

---

## Что такое автотест?

---

```ruby
class Podcast
  attr_reader :subscribers

  def initiliaze
    @subscribers = []
  end

  def subscribe(user)
    @subscribers << user
  end
end
```

---

```ruby
user = User.new
podcast = Podcast.new
podcast.subscribe user

puts podcast.subscribers.size # => 1
```

---

```ruby
describe "Podcast" do
  it "allows to subscribe" do
    user = User.new
    podcast = Podcast.new
    podcast.subscribe user

    expect(podcast.subscribers.size).to eq(1)
  end
end
```

---

## Почему нужны автотесты?

* экономия времени
* обнаружение бага на прод дороже
* Страховка от регрессии
* уверенность при рефакторинге
* как документация

---

## Почему разработчики избегают тестов?

* у нас есть автотесты
* нет времени на тесты
* тесты не дают 100% гарантии
* требования быстро меняются
* тесты усложняют рефакторинг
* проект слишком маленький
* нет культуры в команде

---

## Основы RSpec

---

## Что такое RSpec

---

```ruby
it "should calculate sum" do
  expect(1 + 1).to eq(2)
end
```

---

## Почему RSpec

---

## Установка

--- 

```ruby
bundle add rspec-rails
rails generate rspec:install
```

---

## Демонстрация

* простой тест
* describe
* context
* формат doc/progress

---

## Тестирование Model

---

## Что тестировать

* методы
* валидация
* scopes
* ассоциации

---

## Установка rspec-rails

---

## Тестироване методов модели 

---

## Тестироване валидаций модели 

---

## Тестироване scopes модели 

---

## Тестироване associations модели 

---

## FactoryBot

--- 

```ruby
bundle add factory_bot_rails
rails generate factory_bot:model [Model]
```

---

## Links 

* [Factory Bot Cheat Sheet](https://github.com/brennovich/cheat-ruby-sheets/blob/master/factory_bot.md)
* [FactoryBot Cook Book](https://thoughtbot.github.io/factory_bot/intro.html)
