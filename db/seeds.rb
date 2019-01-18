#clear the database of previous entries to avoid duplication of data
Genre.destroy_all #we'll call just destroy_all on the Genre only.This will delete the books under each genre, thus clearing the table

#add new entries
genre = Genre.create(name: 'Programming')
genre2 = Genre.create(name: "Fiction")

genre.books.create!(title: "The Pragmatic Programmer",rating: 5,finished_at: 3.days.ago)
genre.books.create!(title: "Enger's Game",rating: 4,finished_at: nil)

genre2.books.create!(title: "The Dressmaker",rating: 3,finished_at: 34.days.ago)
genre2.books.create!(title: "A Thousand ways to die in the West",rating: 2,finished_at: 23.days.ago)

