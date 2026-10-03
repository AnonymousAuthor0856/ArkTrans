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

private const val NAME = "026MindMapen"
private const val UI_TYPE = "Productivity"
private const val STYLE_THEME = "Dark Neon"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF00FFFF)
        val secondary = Color(0xFF00FF88)
        val tertiary = Color(0xFFBB86FC)
        val background = Color(0xFF0D0D0D)
        val surface = Color(0xFF1C1C1C)
        val surfaceVariant = Color(0xFF2E2E2E)
        val outline = Color(0xFF3F3F3F)
        val success = Color(0xFF00FFAA)
        val warning = Color(0xFFFFC107)
        val error = Color(0xFFFF1744)
        val onPrimary = Color(0xFF000000)
        val onSecondary = Color(0xFF000000)
        val onTertiary = Color(0xFF000000)
        val onBackground = Color(0xFFFFFFFF)
        val onSurface = Color(0xFFFFFFFF)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
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

private val AppColorScheme = darkColorScheme(
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
    val nodes = remember { mutableStateListOf(Offset(200f, 400f), Offset(500f, 700f), Offset(350f, 250f)) }
    var currentColor by remember { mutableStateOf(AppTokens.Colors.primary) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        floatingActionButton = {
            FloatingActionButton(
                onClick = { nodes.add(Offset((100..600).random().toFloat(), (200..800).random().toFloat())) },
                containerColor = AppTokens.Colors.secondary,
                contentColor = AppTokens.Colors.onSecondary,
                shape = CircleShape
            ) { Text("+", style = MaterialTheme.typography.titleMedium) }
        },
        bottomBar = {
            Surface(
                color = AppTokens.Colors.surfaceVariant,
                tonalElevation = AppTokens.ElevationMapping.level1.elevation
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(AppTokens.Spacing.md),
                    horizontalArrangement = Arrangement.SpaceEvenly,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Button(
                        onClick = { currentColor = AppTokens.Colors.primary },
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary)
                    ) { Text("Cyan") }
                    Button(
                        onClick = { currentColor = AppTokens.Colors.secondary },
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary, contentColor = AppTokens.Colors.onSecondary)
                    ) { Text("Green") }
                    Button(
                        onClick = { currentColor = AppTokens.Colors.tertiary },
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.tertiary, contentColor = AppTokens.Colors.onTertiary)
                    ) { Text("Purple") }
                }
            }
        },
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Neon Mind Map", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.primary) },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.background)
            )
        },
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(AppTokens.Colors.background)
                .pointerInput(Unit) {
                    detectDragGestures { change, _ ->
                        nodes.add(change.position)
                    }
                }
        ) {
            Canvas(modifier = Modifier.fillMaxSize()) {
                for (i in 1 until nodes.size) {
                    drawLine(
                        color = currentColor,
                        start = nodes[i - 1],
                        end = nodes[i],
                        strokeWidth = 6f
                    )
                }
                nodes.forEach {
                    drawCircle(color = currentColor, radius = 20f, center = it)
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

@Preview(showBackground = true, backgroundColor = 0xFF0D0D0D)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}