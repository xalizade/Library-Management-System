USE LibraryDB;
GO

-- Inserting additional books into the Books table
INSERT INTO Books (Title, Author, Genre, CopiesAvailable) 
VALUES 
('Pride and Prejudice', 'Jane Austen', 'Romance', 7),
('The Catcher in the Rye', 'J.D. Salinger', 'Fiction', 4),
('Brave New World', 'Aldous Huxley', 'Dystopian', 3),
('The Odyssey', 'Homer', 'Epic Poetry', 5),
('The Girl on the Train', 'Paula Hawkins', 'Detective', 9),
('Crime and Punishment', 'Fyodor Dostoevsky', 'Psychological Fiction', 2),
('The Hobbit', 'J.R.R. Tolkien', 'Fantasy', 8),
('Frankenstein', 'Mary Shelley', 'Horror', 6),
('Dracula', 'Bram Stoker', 'Horror', 4),
('The Divine Comedy', 'Dante Alighieri', 'Epic Poetry', 3),
('The Alchemist', 'Paulo Coelho', 'Adventure', 10),
('The Little Prince', 'Antoine de Saint-Exupéry', 'Fantasy', 10),
('Sherlock Holmes: A Study in Scarlet', 'Arthur Conan Doyle', 'Detective', 5),
('The Hound of the Baskervilles', 'Arthur Conan Doyle', 'Detective', 4),
('Atomic Habits', 'James Clear', 'Self-help', 7),
('The 7 Habits of Highly Effective People', 'Stephen Covey', 'Self-help', 4),
('The Art of War', 'Sun Tzu', 'Philosophy', 6),
('Murder on the Orient Express', 'Agatha Christie', 'Detective', 6),
('The Girl with the Dragon Tattoo', 'Stieg Larsson', 'Detective', 7),
('The Maltese Falcon', 'Dashiell Hammett', 'Detective', 3);
