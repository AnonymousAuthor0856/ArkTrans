package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
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
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.BottomAppBar
import androidx.compose.material3.Card
import androidx.compose.material3.FloatingActionButton
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.graphics.Path
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat
import kotlin.random.Random

private const val NAME = "068*MetroPlanner*en"
private const val UI_TYPE = "Travel"
private const val STYLE_THEME = "Dark Neon"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF00FFFF)
        val secondary = Color(0xFF00B4FF)
        val tertiary = Color(0xFF8A2BE2)
        val background = Color(0xFF0A0A1A)
        val surface = Color(0xFF141436)
        val surfaceVariant = Color(0xFF1E1E4A)
        val outline = Color(0xFF2E2E5C)
        val success = Color(0xFF00FFAA)
        val warning = Color(0xFFFFCC00)
        val error = Color(0xFFFF4444)
        val onPrimary = Color(0xFF0A0A1A)
        val onSecondary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFFFFFFFF)
        val onSurface = Color(0xFFFFFFFF)
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
        val large = RoundedCornerShape(22.dp)
    }
    object Spacing {
        val sm = 6.dp
        val md = 10.dp
        val lg = 16.dp
        val xl = 24.dp
        val xxl = 36.dp
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

@Composable
fun RootScreen() {
    val stations = remember {
        listOf("A", "B", "C", "D", "E", "F")
    }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        floatingActionButton = {
            FloatingActionButton(
                onClick = {},
                containerColor = AppTokens.Colors.primary,
                contentColor = AppTokens.Colors.onPrimary,
                shape = CircleShape
            ) { Text("+", style = AppTokens.TypographyTokens.title) }
        },
        bottomBar = {
            BottomAppBar(
                containerColor = AppTokens.Colors.surface,
                contentColor = AppTokens.Colors.primary
            ) {
                Row(
                    modifier = Modifier
                        .fillMaxWidth()
                        .padding(horizontal = AppTokens.Spacing.lg),
                    horizontalArrangement = Arrangement.SpaceBetween,
                    verticalAlignment = Alignment.CenterVertically
                ) {
                    Text("Routes", color = AppTokens.Colors.secondary, style = AppTokens.TypographyTokens.body)
                    Text("Planner", color = AppTokens.Colors.onSurface, style = AppTokens.TypographyTokens.body)
                    Text("Tickets", color = AppTokens.Colors.onSurface, style = AppTokens.TypographyTokens.body)
                    Text("Profile", color = AppTokens.Colors.onSurface, style = AppTokens.TypographyTokens.body)
                }
            }
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
                            AppTokens.Colors.background,
                            AppTokens.Colors.surfaceVariant,
                            AppTokens.Colors.background
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Text("Metro Planner", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.primary)
            Canvas(
                modifier = Modifier
                    .fillMaxWidth()
                    .height(260.dp)
                    .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.large)
                    .padding(AppTokens.Spacing.md)
            ) {
                val path = Path()
                val step = size.width / (stations.size - 1)
                stations.forEachIndexed { i, _ ->
                    val x = i * step
                    val y = if (i % 2 == 0) size.height / 4 else size.height * 3 / 4
                    if (i == 0) path.moveTo(x, y) else path.lineTo(x, y)
                }
                drawPath(
                    path,
                    Brush.horizontalGradient(
                        listOf(AppTokens.Colors.secondary, AppTokens.Colors.primary)
                    ),
                    style = androidx.compose.ui.graphics.drawscope.Stroke(width = 6f)
                )
                stations.forEachIndexed { i, s ->
                    val x = i * step
                    val y = if (i % 2 == 0) size.height / 4 else size.height * 3 / 4
                    drawCircle(color = AppTokens.Colors.primary, radius = 16f, center = Offset(x, y))
                    drawCircle(color = AppTokens.Colors.background, radius = 6f, center = Offset(x, y))
                }
            }
            Card(
                shape = AppTokens.Shapes.large,
                colors = androidx.compose.material3.CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                elevation = androidx.compose.material3.CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                ) {
                    Text("Next Departures", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.secondary)
                    listOf("08:45 • Line 1", "09:10 • Line 2", "09:30 • Line 3").forEach {
                        Row(
                            modifier = Modifier.fillMaxWidth(),
                            horizontalArrangement = Arrangement.SpaceBetween
                        ) {
                            Text(it, style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface)
                            Text("On Time", style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.success)
                        }
                    }
                }
            }
            Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
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

@Preview(showBackground = true, backgroundColor = 0xFF0A0A1A)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
