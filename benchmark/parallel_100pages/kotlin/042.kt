package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.Image
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
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
import androidx.compose.ui.graphics.Brush
import androidx.compose.ui.graphics.Color
import androidx.compose.ui.res.painterResource
import androidx.compose.ui.text.TextStyle
import androidx.compose.ui.text.font.FontWeight
import androidx.compose.ui.tooling.preview.Preview
import androidx.compose.ui.unit.Dp
import androidx.compose.ui.unit.dp
import androidx.compose.ui.unit.sp
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "056*PriceCompare*en"
private const val UI_TYPE = "ECommerce"
private const val STYLE_THEME = "Cold Gradient"
private const val LANG = "en"
private const val BASELINE_SIZE = "720x1280"

object AppTokens {
    object Colors {
        val primary = Color(0xFF0EA5E9)
        val secondary = Color(0xFF38BDF8)
        val tertiary = Color(0xFF7DD3FC)
        val background = Color(0xFFF0F9FF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFE0F2FE)
        val outline = Color(0xFFBAE6FD)
        val success = Color(0xFF22C55E)
        val warning = Color(0xFFFACC15)
        val error = Color(0xFFEF4444)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFF1E1E1E)
        val onTertiary = Color(0xFF0F172A)
        val onBackground = Color(0xFF0F172A)
        val onSurface = Color(0xFF0F172A)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 26.sp, fontWeight = FontWeight.Bold)
        val title = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.Medium)
        val body = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Normal)
        val label = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Medium)
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
        val xl = 20.dp
        val xxl = 28.dp
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

data class Product(val id: Int, val name: String, val price: String, val store: String)

@Composable
fun RootScreen() {
    val products = remember {
        listOf(
            Product(1, "Wireless Earbuds", "$59.99", "ShopA"),
            Product(2, "Smart Watch", "$129.99", "ShopB"),
            Product(3, "Laptop Stand", "$39.99", "ShopC"),
            Product(4, "Mechanical Keyboard", "$89.99", "ShopA"),
            Product(5, "Noise Cancel Headset", "$149.99", "ShopB"),
            Product(6, "Ergo Mouse", "$45.99", "ShopC")
        )
    }
    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        containerColor = AppTokens.Colors.background
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
            Text("Cold Gradient Price Compare", style = AppTokens.TypographyTokens.display, color = AppTokens.Colors.onBackground)
            LazyVerticalGrid(
                columns = GridCells.Fixed(2),
                horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
                contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxl)
            ) {
                items(products) { p ->
                    Card(
                        shape = AppTokens.Shapes.large,
                        colors = CardDefaults.cardColors(containerColor = AppTokens.Colors.surface),
                        elevation = CardDefaults.cardElevation(AppTokens.ElevationMapping.level1.elevation)
                    ) {
                        Column(
                            modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.md),
                            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                            horizontalAlignment = Alignment.CenterHorizontally
                        ) {
                            Box(
                                modifier = Modifier
                                    .size(100.dp)
                                    .background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.medium)
                            )
                            Text(p.name, style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.onSurface)
                            Text(p.price, style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.primary)
                            Text(p.store, style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.tertiary)
                            Button(
                                onClick = {},
                                colors = ButtonDefaults.buttonColors(containerColor = AppTokens.Colors.primary, contentColor = AppTokens.Colors.onPrimary),
                                shape = AppTokens.Shapes.medium,
                                modifier = Modifier.fillMaxWidth()
                            ) {
                                Text("Compare", style = AppTokens.TypographyTokens.label)
                            }
                        }
                    }
                }
            }
            Text("Price Update Log", style = AppTokens.TypographyTokens.title, color = AppTokens.Colors.primary)
            LazyColumn(
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
                contentPadding = PaddingValues(bottom = 48.dp)
            ) {
                items(products) { p ->
                    Row(
                        modifier = Modifier.fillMaxWidth().background(AppTokens.Colors.surface, AppTokens.Shapes.small).padding(AppTokens.Spacing.md),
                        horizontalArrangement = Arrangement.SpaceBetween
                    ) {
                        Text("${p.name} (${p.store})", style = AppTokens.TypographyTokens.body, color = AppTokens.Colors.onSurface)
                        Text(p.price, style = AppTokens.TypographyTokens.label, color = AppTokens.Colors.secondary)
                    }
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

@Preview(showBackground = true, backgroundColor = 0xFFF0F9FF)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}
