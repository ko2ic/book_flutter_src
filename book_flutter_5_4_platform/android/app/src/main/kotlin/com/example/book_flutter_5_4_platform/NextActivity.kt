package com.example.book_flutter_5_4_platform

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.os.Bundle
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.appcompat.widget.Toolbar


class NextActivity : AppCompatActivity() {

    companion object {
        fun intent(context: Context) = Intent(context, NextActivity::class.java).apply {
            //flags = Intent.FLAG_ACTIVITY_CLEAR_TOP or Intent.FLAG_ACTIVITY_NEW_TASK
        }
    }

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_next)

        val toolbar = findViewById<Toolbar>(R.id.toolbar)

        setSupportActionBar(toolbar)
        supportActionBar?.setDisplayHomeAsUpEnabled(true)
        toolbar.setNavigationOnClickListener {
            this@NextActivity.setResult(Activity.RESULT_OK, intent)
            this@NextActivity.finish()
        }
        supportActionBar?.title = "title"

        val label = findViewById<TextView>(R.id.label)
        label.text = intent.extras!!["label"] as String
    }
}
