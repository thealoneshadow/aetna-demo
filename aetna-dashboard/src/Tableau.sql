/// Minimal lookup table: id + display_text only
model UserTeamDict {
  id           Int    @id @default(autoincrement()) @map("id")
  displayText  String @map("display_text")          @db.VarChar(255)

  users        User[] @relation("UserTeam")
}

model User {
  id        Int    @id @default(autoincrement()) @map("id")
  email     String @unique                       @map("email") @db.VarChar(255)
  name      String?                              @map("name")  @db.VarChar(255)

  // Minimal FK to the dict table (nullable)
  teamId    Int?                                 @map("team_id")
  team      UserTeamDict? @relation("UserTeam", fields: [teamId], references: [id])

  // keep your existing audit fields as-is if needed
}
