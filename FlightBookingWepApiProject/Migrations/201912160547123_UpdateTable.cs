namespace FlightBookingWepApiProject.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class UpdateTable : DbMigration
    {
        public override void Up()
        {
            DropColumn("dbo.User", "Dob");
        }
        
        public override void Down()
        {
            AddColumn("dbo.User", "Dob", c => c.DateTime(nullable: false));
        }
    }
}
