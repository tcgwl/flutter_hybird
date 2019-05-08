package com.thunderhou.flutterhybrid.android;

import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.FrameLayout;

import io.flutter.facade.Flutter;
import io.flutter.view.FlutterView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        findViewById(R.id.btnInvokeFlutter).setOnClickListener(v -> {
            FragmentTransaction ft = getSupportFragmentManager().beginTransaction();
            ft.replace(R.id.someContainer, Flutter.createFragment("{name:'thunderHou',dataList:['aa','bb','cc']}"));
            ft.commit();
        });
    }
}
