package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Canvas
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyRow
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.CircleShape
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.IconButton
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

private const val NAME = "060CouponPacken"
private const val UI_TYPE = "ECommerce"
private const val STYLE_THEME = "Gradient Flow"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF7B61FF)
        val secondary = Color(0xFF26C6DA)
        val tertiary = Color(0xFFFF8A80)
        val background = Color(0xFFF5F7FF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFF0F2F8)
        val outline = Color(0xFFE0E3EB)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF0B1220)
        val onTertiary = Color(0xFF0B1220)
        val onBackground = Color(0xFF0B1220)
        val onSurface = Color(0xFF0B1220)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 28.sp, fontWeight = FontWeight.Bold)
        val headline = TextStyle(fontSize = 20.sp, fontWeight = FontWeight.SemiBold)
        val title = TextStyle(fontSize = 16.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
    }
    object Shapes {
        val small = RoundedCornerShape(8.dp)
        val medium = RoundedCornerShape(14.dp)
        val large = RoundedCornerShape(20.dp)
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
        val level2 = ShadowSpec(6.dp, 10.dp, 6.dp, 0.16f)
        val level3 = ShadowSpec(10.dp, 14.dp, 8.dp, 0.18f)
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
    headlineMedium = AppTokens.TypographyTokens.headline,
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
            extraSmall = AppTokens.Shapes.small,
            small = AppTokens.Shapes.small,
            medium = AppTokens.Shapes.medium,
            large = AppTokens.Shapes.large,
            extraLarge = AppTokens.Shapes.large
        ),
        content = content
    )
}

data class Coupon(val id: Int, val title: String, val value: String, val colorA: Color, val colorB: Color)
data class MapPin(val x: Float, val y: Float, val label: String, val tint: Color)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val coupons = remember {
        listOf(
            Coupon(1, "Grocery Pack", "-$5", AppTokens.Colors.primary, AppTokens.Colors.secondary),
            Coupon(2, "Cafe Bundle", "-15%", AppTokens.Colors.secondary, AppTokens.Colors.tertiary),
            Coupon(3, "Electro Deal", "-$20", AppTokens.Colors.tertiary, AppTokens.Colors.primary),
            Coupon(4, "Fashion Duo", "-10%", AppTokens.Colors.secondary, AppTokens.Colors.primary)
        )
    }
    val pins = remember {
        mutableStateListOf(
            MapPin(140f, 220f, "A", AppTokens.Colors.primary),
            MapPin(320f, 400f, "B", AppTokens.Colors.secondary),
            MapPin(520f, 300f, "C", AppTokens.Colors.tertiary)
        )
    }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = { Text("Coupon Pack", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface) },
                navigationIcon = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(20.dp).background(MaterialTheme.colorScheme.onSurface, CircleShape))
                    }
                },
                actions = {
                    IconButton(onClick = {}) {
                        Box(modifier = Modifier.size(20.dp).background(MaterialTheme.colorScheme.primary, CircleShape))
                    }
                }
            )
        },
        containerColor = Color.Transparent
    ) { pad ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(pad)
                .background(
                    Brush.verticalGradient(
                        listOf(
                            AppTokens.Colors.secondary.copy(alpha = 0.25f),
                            AppTokens.Colors.background,
                            AppTokens.Colors.primary.copy(alpha = 0.25f)
                        )
                    )
                )
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg)
        ) {
            Text("Nearby Packs", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(16f / 9f)
                    .background(MaterialTheme.colorScheme.surface, AppTokens.Shapes.large)
                    .padding(AppTokens.Spacing.md)
            ) {
                Canvas(modifier = Modifier.fillMaxSize()) {
                    drawRect(color = AppTokens.Colors.surfaceVariant)
                    pins.forEach { p ->
                        drawCircle(color = p.tint, radius = 14f, center = Offset(p.x, p.y))
                    }
                }
                Row(
                    modifier = Modifier
                        .align(Alignment.TopEnd)
                        .background(MaterialTheme.colorScheme.surface.copy(alpha = 0.9f), AppTokens.Shapes.small)
                        .padding(horizontal = AppTokens.Spacing.md, vertical = AppTokens.Spacing.xs),
                    verticalAlignment = Alignment.CenterVertically,
                    horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)
                ) {
                    Box(modifier = Modifier.size(10.dp).background(AppTokens.Colors.primary, CircleShape))
                    Text("A", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                    Box(modifier = Modifier.size(10.dp).background(AppTokens.Colors.secondary, CircleShape))
                    Text("B", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                    Box(modifier = Modifier.size(10.dp).background(AppTokens.Colors.tertiary, CircleShape))
                    Text("C", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface)
                }
            }
            Text("Your Coupon Packs", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
            LazyRow(
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
                contentPadding = PaddingValues(horizontal = AppTokens.Spacing.xs)
            ) {
                items(coupons) { c ->
                    Card(
                        shape = AppTokens.Shapes.large,
                        colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface),
                        elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level2.elevation),
                        modifier = Modifier.size(200.dp, 140.dp)
                    ) {
                        Box(
                            modifier = Modifier
                                .fillMaxSize()
                                .background(
                                    Brush.horizontalGradient(
                                        listOf(c.colorA.copy(alpha = 0.18f), c.colorB.copy(alpha = 0.18f))
                                    )
                                )
                                .padding(AppTokens.Spacing.lg)
                        ) {
                            Column(
                                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                                horizontalAlignment = Alignment.Start
                            ) {
                                Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                                    Box(modifier = Modifier.size(14.dp).background(MaterialTheme.colorScheme.primary, CircleShape))
                                    Text(c.title, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                                }
                                Text(c.value, style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                                Button(
                                    onClick = {},
                                    colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary),
                                    shape = AppTokens.Shapes.medium,
                                    modifier = Modifier.fillMaxWidth().height(40.dp)
                                ) {
                                    Text("Redeem", style = MaterialTheme.typography.labelMedium)
                                }
                            }
                        }
                    }
                }
            }
            Spacer(modifier = Modifier.height(AppTokens.Spacing.sm))
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                verticalAlignment = Alignment.CenterVertically
            ) {
                Button(
                    onClick = {},
                    colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.secondary, contentColor = MaterialTheme.colorScheme.onSecondary),
                    shape = AppTokens.Shapes.large,
                    modifier = Modifier.weight(1f).height(52.dp)
                ) { Text("My Coupons", style = MaterialTheme.typography.titleMedium) }
                Button(
                    onClick = {},
                    colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary),
                    shape = AppTokens.Shapes.large,
                    modifier = Modifier.weight(1f).height(52.dp)
                ) { Text("Explore More", style = MaterialTheme.typography.titleMedium) }
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

@Preview(showBackground = true, backgroundColor = 0xFFF5F7FF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}