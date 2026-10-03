package com.example.singlefileui

import android.os.Bundle
import androidx.activity.ComponentActivity
import androidx.activity.compose.setContent
import androidx.compose.foundation.BorderStroke
import androidx.compose.foundation.background
import androidx.compose.foundation.layout.Arrangement
import androidx.compose.foundation.layout.Box
import androidx.compose.foundation.layout.Column
import androidx.compose.foundation.layout.PaddingValues
import androidx.compose.foundation.layout.Row
import androidx.compose.foundation.layout.Spacer
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.LazyColumn
import androidx.compose.foundation.lazy.items
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.AssistChip
import androidx.compose.material3.AssistChipDefaults
import androidx.compose.material3.Button
import androidx.compose.material3.ButtonDefaults
import androidx.compose.material3.Card
import androidx.compose.material3.CardDefaults
import androidx.compose.material3.CenterAlignedTopAppBar
import androidx.compose.material3.ExperimentalMaterial3Api
import androidx.compose.material3.FilterChip
import androidx.compose.material3.FilterChipDefaults
import androidx.compose.material3.MaterialTheme
import androidx.compose.material3.Scaffold
import androidx.compose.material3.Shapes
import androidx.compose.material3.Surface
import androidx.compose.material3.Text
import androidx.compose.material3.Typography
import androidx.compose.material3.lightColorScheme
import androidx.compose.runtime.Composable
import androidx.compose.runtime.mutableStateListOf
import androidx.compose.runtime.mutableStateOf
import androidx.compose.runtime.remember
import androidx.compose.ui.Alignment
import androidx.compose.ui.Modifier
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

private const val NAME = "010_ShoppingCart_en"
private const val UI_TYPE = "E-commerce Cart"
private const val STYLE_THEME = "Minimal Monochrome"
private const val LANG = "en"
private const val BASELINE_SIZE = "1280x720"

object AppTokens {
    object Colors {
        val primary = Color(0xFF000000)
        val secondary = Color(0xFFFF6F00)
        val tertiary = Color(0xFF4CAF50)
        val background = Color(0xFFFFFFFF)
        val surface = Color(0xFFFFFFFF)
        val surfaceVariant = Color(0xFFF5F5F5)
        val outline = Color(0xFFE0E0E0)
        val success = Color(0xFF4CAF50)
        val warning = Color(0xFFFF9800)
        val error = Color(0xFFF44336)
        val onPrimary = Color(0xFFFFFFFF)
        val onSecondary = Color(0xFFFFFFFF)
        val onTertiary = Color(0xFFFFFFFF)
        val onBackground = Color(0xFF000000)
        val onSurface = Color(0xFF000000)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold, lineHeight = 28.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold, lineHeight = 24.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, lineHeight = 18.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal, lineHeight = 16.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 10.sp, fontWeight = FontWeight.Medium, lineHeight = 14.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(6.dp)
        val medium = RoundedCornerShape(8.dp)
        val large = RoundedCornerShape(12.dp)
    }
    object Spacing {
        val xs = 2.dp
        val sm = 4.dp
        val md = 6.dp
        val lg = 8.dp
        val xl = 12.dp
        val xxl = 16.dp
        val xxxl = 24.dp
    }
    data class ShadowSpec(val elevation: Dp, val radius: Dp, val dy: Dp, val opacity: Float)
    object ElevationMapping {
        val level1 = ShadowSpec(1.dp, 2.dp, 0.5.dp, 0.12f)
        val level2 = ShadowSpec(2.dp, 4.dp, 1.dp, 0.14f)
        val level3 = ShadowSpec(3.dp, 6.dp, 1.5.dp, 0.16f)
        val level4 = ShadowSpec(4.dp, 8.dp, 2.dp, 0.18f)
        val level5 = ShadowSpec(5.dp, 10.dp, 2.5.dp, 0.20f)
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

data class CartItem(val id: Int, val name: String, val price: Double, val color: Color)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val cartItems = remember {
        listOf(
            CartItem(1, "Wireless Headphones", 129.99, AppTokens.Colors.secondary),
            CartItem(2, "Smartphone Case", 24.99, AppTokens.Colors.primary),
            CartItem(3, "USB-C Cable", 19.99, AppTokens.Colors.tertiary),
            CartItem(4, "Portable Charger", 49.99, AppTokens.Colors.secondary)
        )
    }
    val quantities = remember { mutableStateListOf(1, 1, 1, 1) }
    val subtotal = remember { mutableStateOf(0.0) }
    val shipping = 5.99
    val tax = 18.50

    Scaffold(
        contentWindowInsets = androidx.compose.foundation.layout.WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Row(verticalAlignment = Alignment.CenterVertically, horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm)) {
                        Box(modifier = Modifier.size(20.dp).background(AppTokens.Colors.primary, AppTokens.Shapes.small))
                        Text(text = "Shopping Cart", style = MaterialTheme.typography.displayLarge, color = MaterialTheme.colorScheme.onSurface)
                    }
                }
            )
        },
        bottomBar = {
            Surface(color = MaterialTheme.colorScheme.surface, tonalElevation = AppTokens.ElevationMapping.level3.elevation, shadowElevation = AppTokens.ElevationMapping.level3.elevation) {
                Column(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md)) {
                    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                        Text(text = "Subtotal", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "$${"%.2f".format(cartItems.mapIndexed { index, item -> item.price * quantities[index] }.sum())}", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                        Text(text = "Shipping", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "$${"%.2f".format(shipping)}", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                        Text(text = "Tax", style = MaterialTheme.typography.bodyMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "$${"%.2f".format(tax)}", style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.SpaceBetween, verticalAlignment = Alignment.CenterVertically) {
                        Text(text = "Total", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                        Text(text = "$${"%.2f".format(cartItems.mapIndexed { index, item -> item.price * quantities[index] }.sum() + shipping + tax)}", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                    }
                    Button(onClick = {}, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.primary, contentColor = MaterialTheme.colorScheme.onPrimary), shape = AppTokens.Shapes.large, modifier = Modifier.fillMaxWidth().height(44.dp)) {
                        Text(text = "Proceed to Checkout", style = MaterialTheme.typography.titleMedium)
                    }
                }
            }
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        LazyColumn(modifier = Modifier.fillMaxSize().padding(padding).padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg), contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxxl)) {
            items(cartItems) { item ->
                Card(shape = AppTokens.Shapes.large, colors = CardDefaults.cardColors(containerColor = MaterialTheme.colorScheme.surface), elevation = CardDefaults.cardElevation(defaultElevation = AppTokens.ElevationMapping.level2.elevation), border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), modifier = Modifier.fillMaxWidth().heightIn(min = 100.dp)) {
                    Row(modifier = Modifier.fillMaxWidth().padding(AppTokens.Spacing.lg), horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg), verticalAlignment = Alignment.CenterVertically) {
                        Box(modifier = Modifier.size(60.dp).background(item.color, AppTokens.Shapes.medium))
                        Column(modifier = Modifier.weight(1f), verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs), horizontalAlignment = Alignment.Start) {
                            Text(text = item.name, style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            Text(text = "$${"%.2f".format(item.price)}", style = MaterialTheme.typography.headlineMedium, color = MaterialTheme.colorScheme.onSurface)
                            Row(horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                                Box(modifier = Modifier.size(28.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.small))
                                Box(modifier = Modifier.size(28.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.small))
                                Box(modifier = Modifier.size(28.dp).background(AppTokens.Colors.surfaceVariant, AppTokens.Shapes.small))
                            }
                        }
                        Column(verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), horizontalAlignment = Alignment.CenterHorizontally) {
                            Button(onClick = { if (quantities[item.id - 1] < 10) quantities[item.id - 1]++ }, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.surfaceVariant, contentColor = MaterialTheme.colorScheme.onSurface), shape = AppTokens.Shapes.small, modifier = Modifier.size(28.dp)) {
                                Text(text = "+", style = MaterialTheme.typography.titleMedium)
                            }
                            Text(text = quantities[item.id - 1].toString(), style = MaterialTheme.typography.titleMedium, color = MaterialTheme.colorScheme.onSurface)
                            Button(onClick = { if (quantities[item.id - 1] > 1) quantities[item.id - 1]-- }, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.surfaceVariant, contentColor = MaterialTheme.colorScheme.onSurface), shape = AppTokens.Shapes.small, modifier = Modifier.size(28.dp)) {
                                Text(text = "-", style = MaterialTheme.typography.titleMedium)
                            }
                        }
                        Button(onClick = {}, colors = ButtonDefaults.buttonColors(containerColor = MaterialTheme.colorScheme.error, contentColor = MaterialTheme.colorScheme.onPrimary), shape = AppTokens.Shapes.medium, modifier = Modifier.height(36.dp).width(85.dp)) {
                            Text(text = "Remove", style = MaterialTheme.typography.labelMedium)
                        }
                    }
                }
            }
            item {
                Row(modifier = Modifier.fillMaxWidth(), horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm), verticalAlignment = Alignment.CenterVertically) {
                    AssistChip(onClick = {}, label = { Text(text = "Apply Coupon", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = MaterialTheme.colorScheme.surface))
                    AssistChip(onClick = {}, label = { Text(text = "Gift Wrap", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = MaterialTheme.colorScheme.surface))
                    AssistChip(onClick = {}, label = { Text(text = "Save for Later", style = MaterialTheme.typography.labelMedium, color = MaterialTheme.colorScheme.onSurface) }, shape = AppTokens.Shapes.small, border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline), colors = AssistChipDefaults.assistChipColors(containerColor = MaterialTheme.colorScheme.surface))
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
        controller.hide(WindowInsetsCompat.Type.navigationBars())
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
            controller.hide(WindowInsetsCompat.Type.navigationBars())
        }
    }
}

@Preview(showBackground = true, backgroundColor = 0xFFFFFFFF, widthDp = 360, heightDp = 640)
@Composable
fun PreviewRoot() {
    AppTheme {
        RootScreen()
    }
}