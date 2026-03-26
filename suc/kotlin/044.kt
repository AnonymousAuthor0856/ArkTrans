package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
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
import androidx.compose.runtime.mutableFloatStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
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

private const val NAME = "058*OrderTracking*en"
private const val UI_TYPE = "ECommerce"
private const val STYLE_THEME = "Retro Flat"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFFF7043)
        val secondary = Color(0xFFFFB74D)
        val tertiary = Color(0xFFFFD180)
        val background = Color(0xFFFFF3E0)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFFFE0B2)
        val outline = Color(0xFFD7CCC8)
        val success = Color(0xFF66BB6A)
        val warning = Color(0xFFFFCA28)
        val error = Color(0xFFD32F2F)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF3E2723)
        val onBackground = Color(0xFF3E2723)
        val onSurface = Color(0xFF3E2723)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(16.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 16.dp
        val xl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.1f)
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.15f)
        val level3 = ShadowSpec(10.dp, 12.dp, 6.dp, 0.18f)
    }
}

private val AppColorScheme = lightColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
    background = AppTokens.Colors.background,
    onBackground = AppTokens.Colors.onBackground,
    surface = AppTokens.Colors.surface,
    onSurface = AppTokens.Colors.onSurface,
    surfaceVariant = AppTokens.Colors.surfaceVariant,
    outline = AppTokens.Colors.outline
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

@Composable
fun RootScreen() {
    val progress = remember { mutableFloatStateOf(0.45f) }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Text("Order Tracking", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.onBackground)
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(AppTokens.Spacing.lg),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ) {
                    Text("Order #25491", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                    Text("Estimated Delivery: 2 days", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.secondary)
                    LinearProgressIndicator(
                        progress = { progress.floatValue },
                        modifier = Modifier.fillMaxWidth().height(10.dp),
                        color = AppTokens.Colors.primary,
                        trackColor = AppTokens.Colors.surfaceVariant
                    )
                    Row(
                        modifier = Modifier.fillMaxWidth(),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Text("Processing", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.secondary)
                        Text("${(progress.floatValue * 100).toInt()}%", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.primary)
                    }
                }
            }
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .background(AppTokens.Colors.surface, AppTokens.Shapes.large)
                    .padding(AppTokens.Spacing.lg)
            ) {
                Column(
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                    horizontalAlignment = Alignment.CenterHorizontally
                ) {
                    Text("Adjust Progress", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                    Slider(
                        value = progress.floatValue,
                        onValueChange = { progress.floatValue = it },
                        colors = SliderDefaults.colors(
                            thumbColor = AppTokens.Colors.primary,
                            activeTrackColor = AppTokens.Colors.primary,
                            inactiveTrackColor = AppTokens.Colors.surfaceVariant
                        ),
                        modifier = Modifier.fillMaxWidth()
                    )
                    Button(
                        onClick = { progress.floatValue = 1f },
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.fillMaxWidth()
                    ) {
                        Text("Mark as Delivered", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.onPrimary)
                    }
                }
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

@Preview(showBackground = true, backgroundColor = 0xFFFFF3E0)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
