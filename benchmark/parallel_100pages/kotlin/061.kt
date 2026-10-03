package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.border
import androidx.compose.foundation.gestures.detectDragGestures
import androidx.compose.foundation.layout.*
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.*
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.drawscope.Stroke
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
import kotlin.math.max
import kotlin.math.min
import kotlin.random.Random

private const val NAME = "096_ParcelTracker_en"
private const val UI_TYPE = "Tools Dashboard"
private const val STYLE_THEME = "Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF111827)
        val secondary = Color(0xFF374151)
        val tertiary = Color(0xFF6B7280)
        val background = Color(0xFFF9FAFB)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE5E7EB)
        val outline = Color(0xFFD1D5DB)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF111827)
        val onSurface = Color(0xFF1F2937)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(10.dp)
        val large = RoundedCornerShape(16.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 14.dp
        val xl = 22.dp
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
    headlineMedium = AppTokens.TypographyTokens.headline,
    titleMedium = AppTokens.TypographyTokens.title,
    bodyMedium = AppTokens.TypographyTokens.body
)

@Composable
fun AppTheme(content: @Composable () -> Unit) {
    MaterialTheme(
        colorScheme = AppColorScheme,
        typography = AppTypography,
        shapes = androidx.compose.material3.Shapes(
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large
        ),
        content = content
    )
}

@Composable
fun ParcelCanvas() {
    val dragOffset = remember { mutableStateOf(Offset.Zero) }
    val parcelPoints = remember {
        mutableStateListOf<Offset>().apply {
            repeat(25) { add(Offset(Random.nextFloat() * 400f, Random.nextFloat() * 300f)) }
        }
    }

    Box(
        modifier = Modifier
            .fillMaxWidth()
            .height(300.dp)
            .background(AppTokens.Colors.surface, AppTokens.Shapes.large)
            .border(1.dp, AppTokens.Colors.outline, AppTokens.Shapes.large)
            .pointerInput(Unit) {
                detectDragGestures { change, drag ->
                    change.consume()
                    dragOffset.value = Offset(
                        max(0f, min(size.width.toFloat(), dragOffset.value.x + drag.x)),
                        max(0f, min(size.height.toFloat(), dragOffset.value.y + drag.y))
                    )
                }
            },
        contentAlignment = Alignment.Center
    ) {
        Canvas(modifier = Modifier.fillMaxSize().padding(10.dp)) {
            parcelPoints.forEach {
                drawCircle(
                    color = AppTokens.Colors.secondary,
                    radius = 4f,
                    center = it
                )
            }
            drawCircle(
                color = AppTokens.Colors.primary,
                radius = 20f,
                center = dragOffset.value,
                style = Stroke(width = 3f)
            )
        }
        Text("Drag to locate parcel", color = AppTokens.Colors.onSurface, style = MaterialTheme.typography.bodyMedium)
    }
}

@Composable
fun RootScreen() {
    Column(
        modifier = Modifier
            .fillMaxSize()
            .background(
                Brush.verticalGradient(
                    listOf(AppTokens.Colors.surfaceVariant, AppTokens.Colors.background)
                )
            )
            .padding(AppTokens.Spacing.lg),
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xl),
        horizontalAlignment = Alignment.CenterHorizontally
    ) {
        Text("Parcel Tracker", style = MaterialTheme.typography.displayLarge, color = AppTokens.Colors.onBackground)
        ParcelCanvas()
        Text(
            "Visualize parcel movements and positions.",
            style = MaterialTheme.typography.bodyMedium,
            color = AppTokens.Colors.onSurface
        )
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars() or WindowInsetsCompat.Type.statusBars())
        setContent {
            AppTheme { Surface(color = MaterialTheme.colorScheme.background) { RootScreen() } }
        }
    }

    override fun onWindowFocusChanged(hasFocus: Boolean) {
        super.onWindowFocusChanged(hasFocus)
        if (hasFocus) {
            val controller = WindowInsetsControllerCompat(window, window.decorView)
            controller.systemBarsBehavior = WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
            controller.hide(WindowInsetsCompat.Type.navigationBars() or WindowInsetsCompat.Type.statusBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFF9FAFB)
@Composable
fun PreviewRoot() {
    AppTheme { RootScreen() }
}
