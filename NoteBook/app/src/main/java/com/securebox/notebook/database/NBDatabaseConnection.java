package com.securebox.notebook.database;

import androidx.room.Database;
import androidx.room.Insert;
import androidx.room.RoomDatabase;

import com.securebox.notebook.database.dao.AccountInfoDao;
import com.securebox.notebook.database.dao.NotesDao;
import com.securebox.notebook.database.dao.SearchHistoryDao;
import com.securebox.notebook.database.entities.Notes;
import com.securebox.notebook.database.entities.SearchHistory;
import com.securebox.notebook.database.entities.security.AccountInfo;
import com.securebox.notebook.database.entities.security.UserPasswords;

//Contains the collection of DAOs (used to expose the details)
@Database(entities = {Notes.class, SearchHistory.class, AccountInfo.class, UserPasswords.class}, version = 1)
public abstract class NBDatabaseConnection extends RoomDatabase {
    public abstract AccountInfoDao getAccountInfoDao();
    public abstract NotesDao getNotesInfoDao();
    public abstract SearchHistoryDao getSearchHistoryDao();
}
