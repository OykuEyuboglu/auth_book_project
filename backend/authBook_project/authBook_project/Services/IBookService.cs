using authBook_project.DTOs;

namespace authBook_project.Services
{
    public interface IBookService
    {
        Task<List<GetBookDTO>> GetAllBooksAsync();
        Task AddBookAsync(BookCreateDTO dto);
        Task PurchaseBookAsync(string UserEmail, int bookId);
        Task<List<BookDTO>> GetPurchasedBooksAsync(string UserEmail);
    }
}
