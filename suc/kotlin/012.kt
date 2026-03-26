package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.*
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.Stroke
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "009FavoritesGriden"
private const val UI_TYPE = "Social"
private const val STYLE_THEME = "Glassmorphic"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF60A5FA)
        val secondary = Color(0xFF93C5FD)
        val tertiary = Color(0xFFA5B4FC)
        val background = Color(0xFFF9FAFB)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFEFF6FF)
        val outline = Color(0xFFD1D5DB)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFDC2626)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF1E293B)
        val onTertiary = Color(0xFF1E1E2F)
        val onBackground = Color(0xFF111827)
        val onSurface = Color(0xFF111827)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(16.dp)
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
        val level1 = ShadowSpec(1.dp, 4.dp, 2.dp, 0.12f)
        val level2 = ShadowSpec(3.dp, 8.dp, 4.dp, 0.14f)
        val level3 = ShadowSpec(6.dp, 12.dp, 6.dp, 0.16f)
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
    var markerPosition by remember { mutableStateOf(Offset(200f, 400f)) }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text("Favorite Spots Map", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                },
                colors = TopAppBarDefaults.centerAlignedTopAppBarColors(containerColor = MaterialTheme.colorScheme.background)
            )
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { pad ->
        Box(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.linearGradient(
                        colors = listOf(
                            Color.White.copy(alpha = 0.6f),
                            AppTokens.Colors.surfaceVariant.copy(alpha = 0.5f),
                            Color.White.copy(alpha = 0.7f)
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            contentAlignment = Alignment.Center
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(400.dp)
                    .background(
                        Brush.radialGradient(
                            colors = listOf(
                                AppTokens.Colors.surface.copy(alpha = 0.8f),
                                AppTokens.Colors.surfaceVariant.copy(alpha = 0.6f)
                            )
                        ),
                        shape = AppTokens.Shapes.large
                    )
                    .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large),
                contentAlignment = Alignment.Center
            ) {
                Canvas(modifier = Modifier.fillMaxSize()) {
                    drawCircle(
                        color = AppTokens.Colors.secondary.copy(alpha = 0.3f),
                        radius = 220f,
                        center = Offset(size.width / 2, size.height / 2)
                    )
                    drawCircle(
                        color = AppTokens.Colors.secondary.copy(alpha = 0.2f),
                        radius = 340f,
                        center = Offset(size.width / 2, size.height / 2)
                    )
                    drawCircle(
                        color = AppTokens.Colors.primary,
                        radius = 14f,
                        center = markerPosition
                    )
                    drawCircle(
                        color = AppTokens.Colors.primary.copy(alpha = 0.3f),
                        radius = 30f,
                        center = markerPosition,
                        style = Stroke(width = 3f)
                    )
                }
            }
            Column(
                modifier = Modifier.align(Alignment.BottomCenter).fillMaxWidth(),
                horizontalAlignment = Alignment.CenterHorizontally,
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
            ) {
                Text(
                    "Spot Coordinates: (${markerPosition.x.toInt()}, ${markerPosition.y.toInt()})",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurface
                )
                Button(
                    onClick = {},
                    shape = AppTokens.Shapes.medium,
                    colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary),
                    modifier = Modifier.fillMaxWidth().height(48.dp)
                ) {
                    Text("Save Marker", style = MaterialTheme.typography.titleMedium)
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

@Preview(showBackground = true, backgroundColor = 0xFFF9FAFB)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}