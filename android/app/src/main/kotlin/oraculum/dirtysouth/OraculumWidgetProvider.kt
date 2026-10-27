package oraculum.dirtysouth

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.graphics.BitmapFactory
import android.net.Uri
import android.widget.RemoteViews
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetProvider
import java.io.File

class OraculumWidgetProvider : HomeWidgetProvider() {

    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.oraculum_widget).apply {
                val cardTitle = widgetData.getString("card_title", "Daily Tarot Card") ?: "Daily Tarot Card"
                val cardSubtitle = widgetData.getString("card_subtitle", "MAJOR ARCANA • COSMIC MIRROR") ?: "MAJOR ARCANA • COSMIC MIRROR"
                val cardMeaning = widgetData.getString("card_meaning", "Align your thoughts with celestial guidance.") ?: "Align your thoughts with celestial guidance."
                val moonPhase = widgetData.getString("moon_phase", "🌙 Moon Phase") ?: "🌙 Moon Phase"
                val cardImagePath = widgetData.getString("card_image_path", null)

                setTextViewText(R.id.widget_card_title, cardTitle)
                setTextViewText(R.id.widget_card_subtitle, cardSubtitle)
                setTextViewText(R.id.widget_card_meaning, cardMeaning)
                setTextViewText(R.id.widget_moon_phase, moonPhase)

                if (cardImagePath != null && File(cardImagePath).exists()) {
                    try {
                        val bitmap = BitmapFactory.decodeFile(cardImagePath)
                        if (bitmap != null) {
                            setImageViewBitmap(R.id.widget_card_icon, bitmap)
                        } else {
                            setImageViewResource(R.id.widget_card_icon, R.mipmap.ic_launcher)
                        }
                    } catch (e: Exception) {
                        setImageViewResource(R.id.widget_card_icon, R.mipmap.ic_launcher)
                    }
                } else {
                    setImageViewResource(R.id.widget_card_icon, R.mipmap.ic_launcher)
                }

                // Deep link intent to launch Astral Guidance table
                val launchIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("oraculum://daily")
                )
                setOnClickPendingIntent(R.id.widget_root, launchIntent)
                setOnClickPendingIntent(R.id.widget_action_btn, launchIntent)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
