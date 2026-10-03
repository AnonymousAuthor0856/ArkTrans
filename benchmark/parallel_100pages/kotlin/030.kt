package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.LinearProgressIndicator
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Slider
import androidx.compose.material3.SliderDefaults
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.getValue
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.runtime.setValue
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.draw.clip
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.text.style.TextOverflow
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "031_ClipboardHistory_en"
private const val UI_TYPE = "Productivity"
private const val STYLE_THEME = "Modern Blue"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF007BFF)
        val secondary = Color(0xFF6C757D)
        val tertiary = Color(0xFF17A2B8)
        val background = Color(0xFFF8F9FA)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE9ECEF)
        val outline = Color(0xFFDEE2E6)
        val success = Color(0xFF28A745)
        val warning = Color(0xFFFFC107)
        val error = Color(0xFFDC3545)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF212529)
        val onSurface = Color(0xFF212529)
    }

    object TypographyTokens {
        val display = TextStyle(fontSize = 36.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Normal, lineHeight = 24.sp)
        val label = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, letterSpacing = 0.25.sp)
    }

    object Shapes {
        val small = RoundedCornerShape(4.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }

    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
    }

    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 3.dp, 1.dp, 0.1f)
        val level2 = ShadowSpec(3.dp, 6.dp, 2.dp, 0.1f)
        val level3 = ShadowSpec(6.dp, 10.dp, 4.dp, 0.1f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    tertiary = AppTokens.Colors.tertiary,
    onTertiary = AppTokens.Colors.onTertiary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline,
    error = AppTokens.Colors.error
)

private val AppTypography = Typography(
    displayMedium = AppTokens.TypographyTokens.display,
    headlineSmall = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(small = AppTokens.Shapes.small, medium = AppTokens.Shapes.medium, large = AppTokens.Shapes.large),
        content = content
    )
}

data class ClipboardItem(val id: Int, val content: String, val type: String, val timestamp: String, val progress: Float)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val clipboardItems = remember {
        listOf(
            ClipboardItem(1, "https://www.example.com/modern-design", "Link", "5 min ago", 0.2f),
            ClipboardItem(2, "Final project review notes have been updated.", "Text", "23 min ago", 0.5f),
            ClipboardItem(3, "#007BFF", "Color", "1 hour ago", 0.8f),
            ClipboardItem(4, "Meeting at 3 PM with the design team.", "Text", "3 hours ago", 0.9f),
            ClipboardItem(5, "Shared file: 'Q3_Report.pdf'", "File", "Yesterday", 1.0f)
        )
    }
    var sliderValue by remember { mutableStateOf(24f) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        containerColor = AppTokens.Colors.background,
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Clipboard History", style = MaterialTheme.typography.titleMedium) },
                actions = {
                    Button(
                        onClick = {},
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.surfaceVariant, contentColor = AppTokens.Colors.onSurface),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.padding(end = AppTokens.Spacing.md)
                    ) {
                        Text("Clear", style = MaterialTheme.typography.labelMedium)
                    }
                }
            )
        }
    ) { paddingValues ->
        Column(modifier = Modifier.fillMaxSize().padding(paddingValues)) {
            LazyColumn(
                modifier = Modifier.weight(1f),
                contentPadding = PaddingValues(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
            ) {
                items(clipboardItems) { item ->
                    ClipboardCard(item)
                }
            }
            SettingsPane(sliderValue = sliderValue, onSliderChange = { sliderValue = it })
        }
    }
}

@Composable
fun ClipboardCard(item: ClipboardItem) {
    Card(
        modifier = Modifier.fillMaxWidth(),
        shape = AppTokens.Shapes.large,
        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
        elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level1.elevation),
        border = BorderStroke(1.dp, AppTokens.Colors.surfaceVariant)
    ) {
        Column(modifier = Modifier.padding(AppTokens.Spacing.md)) {
            Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                Box(modifier = Modifier.size(24.dp).clip(AppTokens.Shapes.small).background(AppTokens.Colors.primary)) {}
                Text(item.type, style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.primary, fontWeight = FontWeight.Bold)
                Spacer(modifier = Modifier.weight(1f))
                Text(item.timestamp, style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.secondary)
            }
            Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))
            Text(item.content, style = MaterialTheme.typography.bodyMedium, maxLines = 2, overflow = TextOverflow.Ellipsis)
            Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
            LinearProgressIndicator(
                progress = { item.progress },
                modifier = Modifier.fillMaxWidth().height(4.dp).clip(AppTokens.Shapes.small),
                color = AppTokens.Colors.tertiary,
                trackColor = AppTokens.Colors.surfaceVariant
            )
        }
    }
}

@Composable
fun SettingsPane(sliderValue: Float, onSliderChange: (Float) -> Unit) {
    Surface(
        modifier = Modifier.fillMaxWidth(),
        color = AppTokens.Colors.surface,
        tonalElevation = AppTokens.ElevationMapping.level2.elevation,
        shadowElevation = AppTokens.ElevationMapping.level2.elevation
    ) {
        Column(modifier = Modifier.padding(AppTokens.Spacing.lg)) {
            Row(modifier = Modifier.fillMaxWidth(), verticalAlignment = Alignment.CenterVertically) {
                Text("History Limit (Hours)", style = MaterialTheme.typography.labelMedium, color = AppTokens.Colors.onSurface)
                Spacer(modifier = Modifier.weight(1f))
                Text(sliderValue.toInt().toString(), style = MaterialTheme.typography.bodyMedium, fontWeight = FontWeight.SemiBold)
            }
            Slider(
                value = sliderValue,
                onValueChange = onSliderChange,
                valueRange = 1f..72f,
                steps = 70,
                modifier = Modifier.fillMaxWidth(),
                colors = SliderDefaults.colors(
                    thumbColor = AppTokens.Colors.primary,
                    activeTrackColor = AppTokens.Colors.primary,
                    inactiveTrackColor = AppTokens.Colors.surfaceVariant,
                    activeTickColor = AppTokens.Colors.primary.copy(alpha = 0.5f),
                    inactiveTickColor = AppTokens.Colors.surfaceVariant
                )
            )
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.systemBars())
        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.systemBars())
        }
    }
}

@Preview(showBackground = true, widthDp = 360, heightDp = 720)
@Composable
fun DefaultPreview() {
    AppTheme {
        RootScreen()
    }
}
