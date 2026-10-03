package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
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

private const val NAME = "034BillCalendaren"
private const val UI_TYPE = "Finance"
private const val STYLE_THEME = "Gradient Flow"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF06B6D4)
        val secondary = Color(0xFF3B82F6)
        val tertiary = Color(0xFF8B5CF6)
        val background = Color(0xFFF0F9FF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE0F2FE)
        val outline = Color(0xFFBAE6FD)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFFACC15)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
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
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(12.dp)
        val large = RoundedCornerShape(20.dp)
    }
    object Spacing {
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 32.dp
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
    var spending by remember { mutableFloatStateOf(500f) }
    val goal = 1000f

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Bill Calendar", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) },
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
                            AppTokens.Colors.secondary.copy(alpha = 0.3f),
                            AppTokens.Colors.background,
                            AppTokens.Colors.primary.copy(alpha = 0.2f)
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Surface(
                shape = AppTokens.Shapes.large,
                color = AppTokens.Colors.surface.copy(alpha = 0.9f),
                shadowElevation = AppTokens.ElevationMapping.level2.elevation,
                modifier = Modifier.fillMaxWidth().height(160.dp)
            ) {
                Column(
                    modifier = Modifier
                        .fillMaxSize()
                        .padding(AppTokens.Spacing.lg),
                    verticalArrangement = Arrangement.SpaceBetween
                ) {
                    Text("Current Spending", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.primary)
                    Text("$${spending.toInt()} / $${goal.toInt()}", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface)
                    LinearProgressIndicator(
                        progress = { (spending / goal).coerceIn(0f, 1f) },
                        color = AppTokens.Colors.primary,
                        trackColor = AppTokens.Colors.surfaceVariant,
                        modifier = Modifier.fillMaxWidth().height(8.dp)
                    )
                }
            }
            Text("Adjust Spending", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
            Slider(
                value = spending,
                onValueChange = { spending = it },
                valueRange = 0f..2000f,
                colors = SliderDefaults.colors(
                    thumbColor = AppTokens.Colors.secondary,
                    activeTrackColor = AppTokens.Colors.primary,
                    inactiveTrackColor = AppTokens.Colors.surfaceVariant
                ),
                modifier = Modifier.fillMaxWidth()
            )
            Button(
                onClick = { spending = 0f },
                shape = AppTokens.Shapes.medium,
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.tertiary, contentColor = AppTokens.Colors.onTertiary),
                modifier = Modifier.fillMaxWidth().height(48.dp)
            ) {
                Text("Reset", style = MaterialTheme.typography.titleMedium)
            }
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

@Preview(showBackground = true, backgroundColor = 0xFFF0F9FF)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}