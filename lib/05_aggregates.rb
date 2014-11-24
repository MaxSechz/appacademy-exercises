# == Schema Information
#
# Table name: world
#
#  name        :string       not null, primary key
#  continent   :string
#  area        :integer
#  population  :integer
#  gdp         :integer

require_relative './sqlzoo.rb'

def example_sum
  execute(<<-SQL)
    SELECT
      SUM(population)
    FROM
      world
  SQL
end

def continents
  # List all the continents - just once each.
  execute(<<-SQL)
  SELECT DISTINCT
    continent
  FROM
    world
  SQL
end

def africa_gdp
  # Give the total GDP of Africa.
  execute(<<-SQL)
  Select
    sum(GDP)
  FROM
    WORLD
  WHERE
    continent = 'Africa'
  SQL
end

def area_count
  # How many countries have an area of at least 1,000,000?
  execute(<<-SQL)
  SELECT
    count(name)
  FROM
    world
  WHERE
    area > 1000000
  SQL
end

def group_population
  # What is the total population of ('France','Germany','Spain')?
  execute(<<-SQL)
  SELECT
    sum(population)
  FROM
    world
  WHERE
    name = ANY ('{France, Germany, Spain}')
  SQL
end

def country_counts
  # For each continent show the continent and number of countries.
  execute(<<-SQL)
  SELECT
    continent, count(name)
  FROM
    world
  GROUP BY
    continent
  SQL
end

def populous_country_counts
  # For each continent show the continent and number of countries with
  # populations of at least 10 million.
  execute(<<-SQL)
  SELECT
    continent, count(name)
  FROM
    world
  WHERE
    population > 10000000
  GROUP BY
    continent
  SQL
end

def populous_continents
  # List the continents that have a total population of at least 100 million.
  execute(<<-SQL)
  SELECT DISTINCT
    continent
  FROM
    world AS world1
  WHERE
    100000000 < (
      SELECT
        sum(population)
      FROM
        world
      WHERE
        continent = world1.continent
    )
  SQL
end
