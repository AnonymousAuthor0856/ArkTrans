package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.CircleShape
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

private const val NAME = "033TransferWizarden"
private const val UI_TYPE = "Finance"
private const val STYLE_THEME = "Warm Gradient"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFFFA500)
        val secondary = Color(0xFFFFC300)
        val tertiary = Color(0xFFFFE066)
        val background = Color(0xFFFFFBF2)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFFFEED6)
        val outline = Color(0xFFF1C27D)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
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
        val small = CircleShape
        val medium = CircleShape
        val large = CircleShape
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
        val level2 = ShadowSpec(6.dp, 8.dp, 4.dp, 0.16f)
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
    var markerPosition by remember { mutableStateOf(Offset(200f, 400f)) }
    var progress by remember { mutableStateOf(0.4f) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Transfer Wizard", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = AppTokens.Colors.background)
            )
        },
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.verticalGradient(
                        listOf(
                            AppTokens.Colors.secondary.copy(alpha = 0.2f),
                            AppTokens.Colors.background,
                            AppTokens.Colors.primary.copy(alpha = 0.2f)
                        )
                    )
                ),
            contentAlignment = Alignment.Center
        ) {
            Canvas(modifier = Modifier
                .fillMaxSize()
                .padding(AppTokens.Spacing.xl)
            ) {
                val center = Offset(size.width / 2f, size.height / 2f)
                drawCircle(color = AppTokens.Colors.surfaceVariant, radius = 260f, center = center)
                drawCircle(color = AppTokens.Colors.primary, radius = 20f, center = markerPosition)
            }
            Column(
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                modifier = Modifier.align(Alignment.BottomCenter).padding(bottom = AppTokens.Spacing.xxl)
            ) {
                Text("Transfer Progress", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.onSurface)
                LinearProgressIndicator(
                    progress = { progress },
                    color = AppTokens.Colors.primary,
                    trackColor = AppTokens.Colors.surfaceVariant,
                    modifier = Modifier.fillMaxWidth(0.8f).height(8.dp)
                )
                Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)) {
                    Button(
                        onClick = { progress = (progress + 0.1f).coerceAtMost(1f) },
                        shape = CircleShape,
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary)
                    ) { Text("+") }
                    Button(
                        onClick = { progress = (progress - 0.1f).coerceAtLeast(0f) },
                        shape = CircleShape,
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary, contentColor = AppTokens.Colors.onSecondary)
                    ) { Text("-") }
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

@Preview(showBackground = true, backgroundColor = 0xFFFFFBF2)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}