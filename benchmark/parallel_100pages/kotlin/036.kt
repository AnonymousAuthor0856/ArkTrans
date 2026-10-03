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
import kotlin.math.cos
import kotlin.math.PI

private const val NAME = "047CryptoMarketen"
private const val UI_TYPE = "Finance"
private const val STYLE_THEME = "Soft Pastel"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFFFFA8A8)
        val secondary = Color(0xFFFFE1A8)
        val tertiary = Color(0xFFA8FFE1)
        val background = Color(0xFFFFFCF5)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFF7F7F7)
        val outline = Color(0xFFE2E2E2)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFF1E1E1E)
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
    var selectedChip by remember { mutableStateOf("BTC") }
    var progress by remember { mutableFloatStateOf(0.6f) }
    var isAutoUpdate by remember { mutableStateOf(true) }

    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Crypto Market", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onSurface) },
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
                            AppTokens.Colors.tertiary.copy(alpha = 0.3f)
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
            horizontalAlignment = Alignment.CenterHorizontally
        ) {
            Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)) {
                listOf("BTC", "ETH", "SOL", "ADA").forEach {
                    FilterChip(
                        selected = selectedChip == it,
                        onClick = { selectedChip = it },
                        label = { Text(it, color = AppTokens.Colors.onPrimary) },
                        colors = FilterChipDefaults.filterChipColors(
                            containerColor = if (selectedChip == it) AppTokens.Colors.primary else AppTokens.Colors.surfaceVariant,
                            selectedContainerColor = AppTokens.Colors.primary
                        )
                    )
                }
            }
            Surface(
                shape = AppTokens.Shapes.large,
                color = AppTokens.Colors.surface,
                tonalElevation = AppTokens.ElevationMapping.level2.elevation,
                modifier = Modifier.fillMaxWidth().height(260.dp)
            ) {
                Canvas(modifier = Modifier.fillMaxSize().padding(AppTokens.Spacing.lg)) {
                    val w = size.width
                    val h = size.height
                    val step = w / 30
                    var prevY = h / 2
                    for (i in 0..30) {
                        val x = i * step
                        val y = h / 2 + sin(i * PI / 6 + progress * PI).toFloat() * (h / 3)
                        drawLine(
                            color = AppTokens.Colors.primary,
                            start = Offset(x - step, prevY),
                            end = Offset(x, y),
                            strokeWidth = 5f
                        )
                        prevY = y
                    }
                }
            }
            Text("Price Variation", style = MaterialTheme.typography.titleMedium, color = AppTokens.Colors.primary)
            LinearProgressIndicator(
                progress = { progress },
                color = AppTokens.Colors.primary,
                trackColor = AppTokens.Colors.surfaceVariant,
                modifier = Modifier.fillMaxWidth().height(8.dp)
            )
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text("Auto Update", style = MaterialTheme.typography.bodyMedium, color = AppTokens.Colors.onSurface)
                Switch(
                    checked = isAutoUpdate,
                    onCheckedChange = { isAutoUpdate = it },
                    colors = SwitchDefaults.colors(
                        checkedThumbColor = AppTokens.Colors.secondary,
                        uncheckedThumbColor = AppTokens.Colors.outline
                    )
                )
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

@Preview(showBackground = true, backgroundColor = 0xFFFFFCF5)
@Composable
fun PreviewScreen() {
    AppTheme {
        RootScreen()
    }
}