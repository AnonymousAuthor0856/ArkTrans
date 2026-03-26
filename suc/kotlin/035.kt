package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import kotlin.math.sin
import kotlin.math.PI

private const val NAME = "046StockKLineen"
private const val UI_TYPE = "Finance"
private const val STYLE_THEME = "Modern Blue"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF2563EB)
        val secondary = Color(0xFF60A5FA)
        val tertiary = Color(0xFF93C5FD)
        val background = Color(0xFFF8FAFC)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE2E8F0)
        val outline = Color(0xFFCBD5E1)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF1E3A8A)
        val onTertiary = Color(0xFF1E40AF)
        val onBackground = Color(0xFF0F172A)
        val onSurface = Color(0xFF0F172A)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(4.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(16.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 14.dp
        val xl = 20.dp
        val xxl = 28.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.18f)
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
    displayLarge = AppTokens.TypographyTokens.display,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body,
    labelMedium = AppTokens.TypographyTokens.label
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    var progress by remember { mutableFloatStateOf(0.5f) }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Stock K-Line", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.background)
            )
        },
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.verticalGradient(
                        listOf(
                            AppTokens.Colors.secondary.copy(alpha = 0.15f),
                            AppTokens.Colors.background,
                            AppTokens.Colors.primary.copy(alpha = 0.15f)
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Surface(
                shape = AppTokens.Shapes.large,
                color = AppTokens.Colors.surface,
                tonalElevation = AppTokens.ElevationMapping.level2.elevation,
                modifier = Modifier.fillMaxWidth().height(260.dp)
            ) {
                Canvas(modifier = Modifier.fillMaxSize().padding(AppTokens.Spacing.lg)) {
                    val width = size.width
                    val height = size.height
                    val step = width / 50
                    var prevY = height / 2
                    for (i in 0..50) {
                        val x = i * step
                        val y = height / 2 + sin(i * PI / 8 + progress * PI).toFloat() * (height / 3)
                        drawLine(
                            color = AppTokens.Colors.primary,
                            start = Offset(x - step, prevY),
                            end = Offset(x, y),
                            strokeWidth = 4f
                        )
                        prevY = y
                    }
                }
            }
            Text("Market Trend", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.primary)
            Slider(
                value = progress,
                onValueChange = { progress = it },
                valueRange = 0f..1f,
                colors = SliderDefaults.colors(
                    thumbColor = AppTokens.Colors.primary,
                    activeTrackColor = AppTokens.Colors.secondary,
                    inactiveTrackColor = AppTokens.Colors.surfaceVariant
                ),
                modifier = Modifier.fillMaxWidth()
            )
            LinearProgressIndicator(
                progress = { progress },
                color = AppTokens.Colors.primary,
                trackColor = AppTokens.Colors.surfaceVariant,
                modifier = Modifier.fillMaxWidth().height(8.dp)
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

@Preview(showBackground = true, backgroundColor = 0xFFF8FAFC)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}