package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.geometry.Size
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

private const val NAME = "020RemoteControlen"
private const val UI_TYPE = "Media"
private const val STYLE_THEME = "Retro Flat"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFFF7A00)
        val secondary = Color(0xFFFFC300)
        val tertiary = Color(0xFFFFF3C0)
        val background = Color(0xFFFFF8E7)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFFFEBC8)
        val outline = Color(0xFFBCA789)
        val success = Color(0xFF28A745)
        val warning = Color(0xFFFFC107)
        val error = Color(0xFFDC3545)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF1E1E1E)
        val onTertiary = Color(0xFF1E1E1E)
        val onBackground = Color(0xFF1E1E1E)
        val onSurface = Color(0xFF1E1E1E)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(14.dp)
        val large = RoundedCornerShape(24.dp)
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
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.16f)
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
    var knobPosition by remember { mutableStateOf(Offset(0f, 0f)) }
    var powerOn by remember { mutableStateOf(false) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Retro Remote Control", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) },
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
            horizontalAlignment = Alignment.CenterHorizontally,
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xl)
        ) {
            Surface(
                modifier = Modifier
                    .size(280.dp)
                    .background(AppTokens.Colors.surfaceVariant, shape = AppTokens.Shapes.large),
                shape = AppTokens.Shapes.large,
                color = AppTokens.Colors.surfaceVariant,
                tonalElevation = AppTokens.ElevationMapping.level1.elevation,
                shadowElevation = AppTokens.ElevationMapping.level1.elevation
            ) {
                Box(
                    modifier = Modifier
                        .fillMaxSize()
                        .padding(AppTokens.Spacing.lg),
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
                            color = AppTokens.Colors.secondary.copy(alpha = 0.2f),
                            radius = 200f,
                            center = center
                        )
                        drawCircle(
                            color = AppTokens.Colors.primary,
                            radius = 24f,
                            center = knobPosition
                        )
                    }
                }
            }
            Text(
                text = if (powerOn) "Power: ON" else "Power: OFF",
                style = MaterialTheme.typography.titleMedium,
                color = if (powerOn) AppTokens.Colors.success else AppTokens.Colors.error
            )
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceEvenly
            ) {
                Button(
                    onClick = { powerOn = !powerOn },
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                    shape = CircleShape,
                    modifier = Modifier.size(80.dp)
                ) {
                    Text(if (powerOn) "Off" else "On", style = MaterialTheme.typography.titleMedium)
                }
                Button(
                    onClick = { knobPosition = Offset.Zero },
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary, contentColor = AppTokens.Colors.onSecondary),
                    shape = CircleShape,
                    modifier = Modifier.size(80.dp)
                ) {
                    Text("Reset", style = MaterialTheme.typography.titleMedium)
                }
            }
            LinearProgressIndicator(
                progress = { (knobPosition.x + knobPosition.y) % 400 / 400f },
                color = AppTokens.Colors.primary,
                trackColor = AppTokens.Colors.surfaceVariant,
                modifier = Modifier.fillMaxWidth().height(6.dp)
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

@Preview(showBackground = true, backgroundColor = 0xFFFFF8E7)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}