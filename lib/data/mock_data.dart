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
   const Book(
    id: '7',
    title: 'Wool',
    author: 'Hugh Howey',
    description: ' Wool is the story of mankind clawing for survival. The world outside has grown toxic, the view of it limited, talk of it forbidden. The remnants of humanity live underground in a single silo.',
    price: 12.39,
    coverImageUrl: 'images/p8.webp', // Placeholder image
    genre: 'Mystery',
  ),
  const Book(
    id: '8',
    title: 'The Lord of the Rings',
    author: 'J R R Tolkien',
    description: ' the war of the peoples of the fantasy world Middle-earth against a dark lord known as "Sauron." At the same time they try to destroy a ring which would give Sauron a lot of power if he got it, but the only place to destroy the ring is deep into Saurons land Mordor.',
    price: 30.52,
    coverImageUrl: 'images/p9.jpg', // Placeholder image
    genre: 'Fantasy',
  ),
  const Book(
    id: '9',
    title: 'Harry Potter and the Goblet of Fire',
    author: 'J.K.Rowling',
    description: 'It follows Harry Potter, a wizard in his fourth year at Hogwarts School of Witchcraft and Wizardry, and the mystery surrounding the entry of Harrys name into the Triwizard Tournament, in which he is forced to compete.',
    price: 7.69,
    coverImageUrl: 'images/p10.png', // Placeholder image
    genre: 'Fantasy',
  ),
    const Book(
    id: '10',
    title: 'A Song of Ice and Fire',
    author: 'George R. R. Martin',
    description: 'A Song of Ice and Fire depicts a violent world dominated by political realism. What little supernatural power exists is confined to the margins of the known world. Moral ambiguity pervades the books',
    price: 19.28,
    coverImageUrl: 'images/p11.jpg', // Placeholder image
    genre: 'Fantasy',
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
