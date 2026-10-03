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

private const val NAME = "016AudioMixeren"
private const val UI_TYPE = "Media"
private const val STYLE_THEME = "Monochrome Terminal"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF00FF66)
        val secondary = Color(0xFFCCCCCC)
        val tertiary = Color(0xFF999999)
        val background = Color(0xFF000000)
        val surface = Color(0xFF0A0A0A)
        val surfaceVariant = Color(0xFF141414)
        val outline = Color(0xFF2A2A2A)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFF000000)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFFE0E0E0)
        val onSurface = Color(0xFFE0E0E0)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 13.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 11.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(14.dp)
    }
    object Spacing {
        val xs = 4.dp
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 32.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(0.dp, 0.dp, 0.dp, 0f)
        val level2 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
    }
}

private val AppColorScheme = darkColorScheme(
    primary = AppTokens.Colors.primary,
    onPrimary = AppTokens.Colors.onPrimary,
    secondary = AppTokens.Colors.secondary,
    onSecondary = AppTokens.Colors.onSecondary,
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
    var bass by remember { mutableFloatStateOf(0.4f) }
    var mid by remember { mutableFloatStateOf(0.5f) }
    var treble by remember { mutableFloatStateOf(0.6f) }
    var master by remember { mutableFloatStateOf(0.7f) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text("Audio Mixer Terminal", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.primary)
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.background)
            )
        },
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(AppTokens.Colors.background)
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            MixerSlider("Bass", bass) { bass = it }
            MixerSlider("Mid", mid) { mid = it }
            MixerSlider("Treble", treble) { treble = it }
            Spacer(Modifier.height(AppTokens.Spacing.lg))
            LinearProgressIndicator(
                progress = { master },
                color = AppTokens.Colors.primary,
                trackColor = AppTokens.Colors.surfaceVariant,
                modifier = Modifier.fillMaxWidth().height(6.dp)
            )
            Text(
                text = "Master Volume ${(master * 100).toInt()}%",
                style = MaterialTheme.typography.titleMedium,
                color = AppTokens.Colors.onSurface
            )
            Slider(
                value = master,
                onValueChange = { master = it },
                colors = SliderDefaults.colors(
                    thumbColor = AppTokens.Colors.primary,
                    activeTrackColor = AppTokens.Colors.primary,
                    inactiveTrackColor = AppTokens.Colors.surfaceVariant
                ),
                modifier = Modifier.fillMaxWidth()
            )
            Button(
                onClick = {},
                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                shape = AppTokens.Shapes.medium,
                modifier = Modifier.fillMaxWidth().height(48.dp)
            ) {
                Text("Apply Settings", style = MaterialTheme.typography.titleMedium)
            }
        }
    }


}

@Composable
fun MixerSlider(label: String, value: Float, onChange: (Float) -> Unit) {
    Column(
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs),
        horizontalAlignment = Alignment.Start
    ) {
        Text("$label ${(value * 100).toInt()}%", style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
        Slider(
            value = value,
            onValueChange = onChange,
            colors = SliderDefaults.colors(
                thumbColor = AppTokens.Colors.primary,
                activeTrackColor = AppTokens.Colors.primary,
                inactiveTrackColor = AppTokens.Colors.surfaceVariant
            ),
            modifier = Modifier.fillMaxWidth()
        )
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

@Preview(showBackground = true, backgroundColor = 0xFF000000)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}