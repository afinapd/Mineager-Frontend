package com.example.final_project;

import android.os.AsyncTask;

import com.rscja.deviceapi.RFIDWithUHF;

public class InitUhf {
    RFIDWithUHF mReader;


    public InitUhf() {
        try {
            mReader = RFIDWithUHF.getInstance();
        } catch (Exception ex) {
            return;
        }

        if (mReader != null) {
            new InitTask().execute();
        }
    }

    public RFIDWithUHF getmReader() {
        return mReader;
    }

    class InitTask extends AsyncTask<String, Integer, Boolean> {

        @Override
        protected Boolean doInBackground(String... strings) {
            return mReader.init();
        }
    }
}


