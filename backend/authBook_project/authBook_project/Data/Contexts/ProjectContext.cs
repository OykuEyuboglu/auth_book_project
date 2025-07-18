using Microsoft.EntityFrameworkCore;
using authBook_project.Data.Entities;

namespace authBook_project.Data.Contexts
{
    public class ProjectContext : DbContext
    {
        public DbSet<User> Users { get; set; }
        public DbSet<Book> Books { get; set; }
        public DbSet<UserBook> UserBooks { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<UserBook>().HasKey(x => new {x.UserId, x.BookId});

            modelBuilder.Entity<UserBook>().HasOne(x => x.User).WithMany(u => u.UserBooks).HasForeignKey(x => x.UserId);

            modelBuilder.Entity<UserBook>().HasOne(x =>x.Book).WithMany(u => u.UserBooks).HasForeignKey(x => x.BookId);
        }

        public ProjectContext(DbContextOptions<ProjectContext> options)
          : base(options)
        {
        }


    }
}
