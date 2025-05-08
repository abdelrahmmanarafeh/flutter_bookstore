import '../models/book.dart'; // Import the Book model

// List of mock book data for demonstration purposes.
// In a real app, this data would likely come from an API.
final List<Book> mockBooks = [
  const Book(
    id: '1',
    title: 'The Hitchhiker\'s Guide to the Galaxy',
    author: 'Douglas Adams',
    description: 'A hilarious science fiction comedy series.',
    price: 12.99,
    coverImageUrl: 'images/p1.jpg',
    genre: 'Science Fiction',
  ),
  const Book(
    id: '2',
    title: 'Pride and Prejudice',
    author: 'Jane Austen',
    description: 'A classic romance novel.',
    price: 9.99,
    coverImageUrl: 'images/p3.jpg', // Placeholder image
    genre: 'Romance',
  ),
  const Book(
    id: '3',
    title: '1984',
    author: 'George Orwell',
    description: 'A dystopian social science fiction novel and cautionary tale.',
    price: 10.49,
    coverImageUrl: 'images/p2.jpeg', // Placeholder image
    genre: 'Dystopian',
  ),
  const Book(
    id: '4',
    title: 'To Kill a Mockingbird',
    author: 'Harper Lee',
    description: 'A novel about the seriousness of the issues of rape and racial inequality.',
    price: 11.99,
    coverImageUrl: 'images/p5.jpg', // Placeholder image
    genre: 'Classic',
  ),
   const Book(
    id: '5',
    title: 'The Great Gatsby',
    author: 'F. Scott Fitzgerald',
    description: 'A novel set in the Jazz Age on Long Island.',
    price: 8.99,
    coverImageUrl: 'images/p6.webp', // Placeholder image
    genre: 'Classic',
  ),
   const Book(
    id: '6',
    title: 'Dune',
    author: 'Frank Herbert',
    description: 'A landmark science fiction novel set in the distant future amidst a feudal interstellar society.',
    price: 15.99,
    coverImageUrl: 'images/p7.jpg', // Placeholder image
    genre: 'Science Fiction',
  ),
];

// List of mock categories
final List<String> mockCategories = [
  'Science Fiction',
  'Romance',
  'Dystopian',
  'Classic',
  'Mystery',
  'Fantasy',
];
