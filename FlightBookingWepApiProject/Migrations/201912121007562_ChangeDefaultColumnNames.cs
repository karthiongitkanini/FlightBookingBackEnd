namespace FlightBookingWepApiProject.Migrations
{
    using System;
    using System.Data.Entity.Migrations;
    
    public partial class ChangeDefaultColumnNames : DbMigration
    {
        public override void Up()
        {
            AddColumn("dbo.User", "Firstname", c => c.String());
            AddColumn("dbo.User", "Lastname", c => c.String());
            AddColumn("dbo.User", "Dob", c => c.DateTime(nullable: false));
        }
        
        public override void Down()
        {
            DropColumn("dbo.User", "Dob");
            DropColumn("dbo.User", "Lastname");
            DropColumn("dbo.User", "Firstname");
        }
    }
}
