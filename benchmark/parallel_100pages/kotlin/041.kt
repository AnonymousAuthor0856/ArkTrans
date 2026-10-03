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
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.Icon
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
import androidx.compose.ui.geometry.Offset
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
import kotlin.random.Random

private const val NAME = "055*ProductDetail*en"
private const val UI_TYPE = "ECommerce"
private const val STYLE_THEME = "Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF111111)
        val secondary = Color(0xFF333333)
        val tertiary = Color(0xFF777777)
        val background = Color(0xFFFFFFFF)
        val surface = Color(0xFFF9F9F9)
        val surfaceVariant = Color(0xFFE5E5E5)
        val outline = Color(0xFFCCCCCC)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFDC2626)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFF111111)
        val onBackground = Color(0xFF111111)
        val onSurface = Color(0xFF111111)
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
        val large = RoundedCornerShape(14.dp)
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
        val level1 = ShadowSpec(2.dp, 4.dp, 2.dp, 0.1f)
        val level2 = ShadowSpec(4.dp, 8.dp, 4.dp, 0.12f)
        val level3 = ShadowSpec(8.dp, 12.dp, 6.dp, 0.15f)
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

data class Marker(val x: Float, val y: Float, val label: String)

@Composable
fun RootScreen() {
    val markers = remember {
        mutableStateListOf(
            Marker(120f, 200f, "Store A"),
            Marker(360f, 400f, "Store B")
        )
    }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background
    ) { pad ->
        Column(
            modifier = Modifier.fillMaxSize().padding(pad).padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Text("Product Detail", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.primary)
            Card(
                shape = AppTokens.Shapes.large,
                colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation),
                modifier = Modifier.fillMaxWidth()
            ) {
                Column(
                    modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg),
                    verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)
                ) {
                    Box(modifier = Modifier.fillMaxWidth().height(160.dp).background(AppTokens.Colors.surfaceVariant))
                    Text("Monochrome Bag", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                    Text("A minimalist and timeless design piece.", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.tertiary)
                    Text("$79.00", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
                    Button(
                        onClick = {},
                        colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                        shape = AppTokens.Shapes.medium,
                        modifier = Modifier.fillMaxWidth().height(48.dp)
                    ) {
                        Text("Add to Cart", style = AppTokens.TypographyTokens.title)
                    }
                }
            }
            Box(
                modifier = Modifier.fillMaxWidth().height(240.dp).background(AppTokens.Colors.surface, AppTokens.Shapes.large)
            ) {
                Canvas(modifier = Modifier.fillMaxSize().padding(AppTokens.Spacing.lg)) {
                    drawRect(color = AppTokens.Colors.surfaceVariant)
                    markers.forEach {
                        drawCircle(color = AppTokens.Colors.primary, radius = 14f, center = Offset(it.x, it.y))
                    }
                }
            }
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Button(
                    onClick = {
                        markers.add(
                            Marker(
                                Random.nextInt(100, 500).toFloat(),
                                Random.nextInt(150, 450).toFloat(),
                                "New"
                            )
                        )
                    },
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.secondary, contentColor = AppTokens.Colors.onSecondary),
                    shape = AppTokens.Shapes.medium,
                    modifier = Modifier.weight(1f).height(44.dp)
                ) { Text("Add Marker", style = AppTokens.TypographyTokens.label) }
                Spacer(modifier = Modifier.size(AppTokens.Spacing.md))
                Button(
                    onClick = { markers.clear() },
                    colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.tertiary, contentColor = AppTokens.Colors.onTertiary),
                    shape = AppTokens.Shapes.medium,
                    modifier = Modifier.weight(1f).height(44.dp)
                ) { Text("Clear", style = AppTokens.TypographyTokens.label) }
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

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
