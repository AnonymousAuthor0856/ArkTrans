package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.input.pointer.pointerInput
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "024PomodoroTimeren"
private const val UI_TYPE = "Productivity"
private const val STYLE_THEME = "Soft Pastel"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFFF8FAB)
        val secondary = Color(0xFFB4E3D0)
        val tertiary = Color(0xFFFFD6A5)
        val background = Color(0xFFFFFCF9)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFFDE2E4)
        val outline = Color(0xFFFCC2D7)
        val success = Color(0xFF4ADE80)
        val warning = Color(0xFFFACC15)
        val error = Color(0xFFFB7185)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF1E1E1E)
        val onTertiary = Color(0xFF1E1E1E)
        val onBackground = Color(0xFF1E1E1E)
        val onSurface = Color(0xFF1E1E1E)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 30.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = CircleShape
        val medium = CircleShape
        val large = CircleShape
    }
    object Spacing {
        val sm = 8.dp
        val md = 12.dp
        val lg = 16.dp
        val xl = 24.dp
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
        content = content
    )
}

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    var knobPosition by remember { mutableStateOf(Offset(0f, 0f)) }
    var isRunning by remember { mutableStateOf(false) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Pomodoro Timer", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.background)
            )
        },
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xl),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Surface(
                modifier = Modifier.size(280.dp),
                shape = CircleShape,
                color = AppTokens.Colors.surfaceVariant,
                shadowElevation = AppTokens.ElevationMapping.level2.elevation
            ) {
                Box(
                    modifier = Modifier.fillMaxSize(),
                    contentAlignment = Alignment.Center
                ) {
                    Canvas(modifier = Modifier
                        .fillMaxSize()
                        .pointerInput(Unit) {
                            detectDragGestures { change, _ ->
                                knobPosition = change.position
                            }
                        }) {
                        val center = Offset(size.width / 2f, size.height / 2f)
                        drawCircle(
                            color = AppTokens.Colors.secondary.copy(alpha = 0.4f),
                            radius = 180f,
                            center = center
                        )
                        drawCircle(
                            color = AppTokens.Colors.primary,
                            radius = 30f,
                            center = knobPosition
                        )
                    }
                }
            }
            Text(
                text = if (isRunning) "Focus Mode ON" else "Focus Mode OFF",
                style = MaterialTheme.typography.titleMedium,
                color = if (isRunning) AppTokens.Colors.success else AppTokens.Colors.error
            )
            Row(
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Button(
                    onClick = { isRunning = true },
                    shape = CircleShape,
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary),
                    modifier = Modifier.size(90.dp)
                ) {
                    Text("Start", color = AppTokens.Colors.onPrimary)
                }
                Button(
                    onClick = { isRunning = false },
                    shape = CircleShape,
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.tertiary),
                    modifier = Modifier.size(90.dp)
                ) {
                    Text("Stop", color = AppTokens.Colors.onSecondary)
                }
            }
            LinearProgressIndicator(
                progress = { (knobPosition.x + knobPosition.y) % 400 / 400f },
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

@Preview(showBackground = true, backgroundColor = 0xFFFFFCF9)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}