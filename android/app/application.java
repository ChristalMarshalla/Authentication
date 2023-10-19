import android.app.Application;
import androidx.multidex.MultiDex;

public class MyApplication extends Application {
    @Override
    protected void onCreate() {
        super.onCreate();
        MultiDex.install(this);
    }
}
