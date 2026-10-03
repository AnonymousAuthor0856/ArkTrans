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
import androidx.compose.foundation.layout.WindowInsets
import androidx.compose.foundation.layout.aspectRatio
import androidx.compose.foundation.layout.fillMaxSize
import androidx.compose.foundation.layout.fillMaxWidth
import androidx.compose.foundation.layout.height
import androidx.compose.foundation.layout.heightIn
import androidx.compose.foundation.layout.padding
import androidx.compose.foundation.layout.size
import androidx.compose.foundation.layout.width
import androidx.compose.foundation.lazy.grid.GridCells
import androidx.compose.foundation.lazy.grid.LazyVerticalGrid
import androidx.compose.foundation.lazy.grid.items
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
import androidx.compose.foundation.shape.RoundedCornerShape
import androidx.compose.material3.Shapes
import androidx.core.view.WindowCompat
import androidx.core.view.WindowInsetsCompat
import androidx.core.view.WindowInsetsControllerCompat

private const val NAME = "001_EcommerceList_en"
private const val UI_TYPE = "E-commerce Product List with Filters"
private const val STYLE_THEME = "Material-You vivid"
private const val LANG = "en"
private const val BASELINE_SIZE = "1280x720"

object AppTokens {
    object Colors {
        val primary = Color(0xFF6750A4)
        val onPrimary = Color(0xFFFFFFFF)
        val secondary = Color(0xFF6CC24A)
        val onSecondary = Color(0xFF0A0F0A)
        val tertiary = Color(0xFFFFB300)
        val onTertiary = Color(0xFF1F1400)
        val background = Color(0xFFF6F7FB)
        val onBackground = Color(0xFF0F172A)
        val surface = Color(0xFFFCFCFF)
        val onSurface = Color(0xFF111827)
        val surfaceVariant = Color(0xFFEEF0F6)
        val outline = Color(0xFFD0D5DD)
        val success = Color(0xFF16A34A)
        val warning = Color(0xFFF59E0B)
        val error = Color(0xFFD92D20)
    }
    object TypographyTokens {
        val display = TextStyle(fontSize = 22.sp, fontWeight = FontWeight.SemiBold, lineHeight = 28.sp, letterSpacing = 0.sp)
        val headline = TextStyle(fontSize = 18.sp, fontWeight = FontWeight.SemiBold, lineHeight = 24.sp, letterSpacing = 0.sp)
        val title = TextStyle(fontSize = 14.sp, fontWeight = FontWeight.Medium, lineHeight = 20.sp, letterSpacing = 0.sp)
        val body = TextStyle(fontSize = 12.sp, fontWeight = FontWeight.Normal, lineHeight = 16.sp, letterSpacing = 0.sp)
        val label = TextStyle(fontSize = 10.sp, fontWeight = FontWeight.Medium, lineHeight = 14.sp, letterSpacing = 0.sp)
    }
    object Shapes {
        val small = RoundedCornerShape(4.dp)
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
        val level5 = ShadowSpec(5.dp, 10.dp, 2.5.dp, 0.2f)
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

data class ProductUi(val id: Int, val title: String, val price: String, val badge: String, val rating: String, val color: Color)

@OptIn(ExperimentalMaterial3Api::class)
@Composable
fun RootScreen() {
    val categories = listOf("All", "Snacks", "Drinks", "Fruits", "Bakery", "Dairy")
    val selected = remember { mutableStateOf("All") }
    val filters = remember { mutableStateListOf("In Stock") }
    val products = remember {
        List(8) { i ->
            val palette = listOf(
                Color(0xFFE0E7FF),
                Color(0xFFD1FAE5),
                Color(0xFFFFEDD5),
                Color(0xFFFDE68A),
                Color(0xFFEDE9FE),
                Color(0xFFFFE4E6),
                Color(0xFFE2E8F0),
                Color(0xFFFFFBEB)
            )
            ProductUi(
                id = i,
                title = "Product ${i + 1}",
                price = "$${(9..49).random()}.99",
                badge = if (i % 3 == 0) "NEW" else if (i % 4 == 0) "SALE" else "",
                rating = "${(4..5).random()}.${(0..9).random()}",
                color = palette[i % palette.size]
            )
        }
    }
    Scaffold(
        contentWindowInsets = WindowInsets(0),
        topBar = {
            CenterAlignedTopAppBar(
                title = {
                    Text(
                        text = "Shop",
                        style = MaterialTheme.typography.displayLarge,
                        color = MaterialTheme.colorScheme.onSurface
                    )
                }
            )
        },
        bottomBar = {
            BottomActionBar(
                subtotal = "$129.96",
                actionLabel = "Checkout",
                onAction = {}
            )
        },
        containerColor = MaterialTheme.colorScheme.background
    ) { padding ->
        Column(
            modifier = Modifier
                .fillMaxSize()
                .padding(padding)
                .padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
            verticalArrangement = Arrangement.Top,
            horizontalAlignment = Alignment.Start
        ) {
            CategoryRow(
                items = categories,
                selected = selected.value,
                onSelect = { selected.value = it }
            )
            Spacer(modifier = Modifier.height(AppTokens.Spacing.md))
            FilterRow(
                filters = filters,
                onToggle = { label ->
                    if (filters.contains(label)) filters.remove(label) else filters.add(label)
                }
            )
            Spacer(modifier = Modifier.height(AppTokens.Spacing.lg))
            ProductGrid(products = products)
            Spacer(modifier = Modifier.height(AppTokens.Spacing.xxxl))
        }
    }
}

@Composable
fun CategoryRow(items: List<String>, selected: String, onSelect: (String) -> Unit) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .heightIn(min = 36.dp),
        horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
        verticalAlignment = Alignment.CenterVertically
    ) {
        items.forEach { label ->
            val active = label == selected
            FilterChip(
                selected = active,
                onClick = { onSelect(label) },
                label = {
                    Text(
                        text = label,
                        style = if (active) MaterialTheme.typography.titleMedium else MaterialTheme.typography.bodyMedium,
                        color = if (active) MaterialTheme.colorScheme.onPrimary else MaterialTheme.colorScheme.onSurface
                    )
                },
                colors = FilterChipDefaults.filterChipColors(
                    containerColor = if (active) MaterialTheme.colorScheme.primary else MaterialTheme.colorScheme.surface,
                    selectedContainerColor = MaterialTheme.colorScheme.primary
                ),
                shape = AppTokens.Shapes.medium,
                border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline)
            )
        }
    }
}

@Composable
fun FilterRow(filters: List<String>, onToggle: (String) -> Unit) {
    Row(
        modifier = Modifier
            .fillMaxWidth()
            .heightIn(min = 32.dp),
        horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.sm),
        verticalAlignment = Alignment.CenterVertically
    ) {
        AssistChip(
            onClick = { onToggle("In Stock") },
            label = {
                Text(
                    text = if (filters.contains("In Stock")) "In Stock" else "In Stock",
                    style = MaterialTheme.typography.labelMedium,
                    color = if (filters.contains("In Stock")) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface
                )
            },
            shape = AppTokens.Shapes.small,
            border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
            colors = AssistChipDefaults.assistChipColors(
                containerColor = if (filters.contains("In Stock")) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface
            )
        )
        AssistChip(
            onClick = { onToggle("Under $20") },
            label = {
                Text(
                    text = if (filters.contains("Under $20")) "Under $20" else "Under $20",
                    style = MaterialTheme.typography.labelMedium,
                    color = if (filters.contains("Under $20")) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface
                )
            },
            shape = AppTokens.Shapes.small,
            border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
            colors = AssistChipDefaults.assistChipColors(
                containerColor = if (filters.contains("Under $20")) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface
            )
        )
        AssistChip(
            onClick = { onToggle("Rating 4+") },
            label = {
                Text(
                    text = if (filters.contains("Rating 4+")) "Rating 4+" else "Rating 4+",
                    style = MaterialTheme.typography.labelMedium,
                    color = if (filters.contains("Rating 4+")) MaterialTheme.colorScheme.onSecondary else MaterialTheme.colorScheme.onSurface
                )
            },
            shape = AppTokens.Shapes.small,
            border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
            colors = AssistChipDefaults.assistChipColors(
                containerColor = if (filters.contains("Rating 4+")) MaterialTheme.colorScheme.secondary else MaterialTheme.colorScheme.surface
            )
        )
    }
}

@Composable
fun ProductGrid(products: List<ProductUi>) {
    LazyVerticalGrid(
        columns = GridCells.Fixed(2),
        verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
        horizontalArrangement = Arrangement.spacedBy(AppTokens.Spacing.lg),
        contentPadding = PaddingValues(bottom = AppTokens.Spacing.xxl)
    ) {
        items(products) { p ->
            ProductCard(p)
        }
    }
}

@Composable
fun ProductCard(p: ProductUi) {
    Card(
        shape = AppTokens.Shapes.large,
        colors = CardDefaults.cardColors(
            containerColor = MaterialTheme.colorScheme.surface
        ),
        elevation = CardDefaults.cardElevation(
            defaultElevation = AppTokens.ElevationMapping.level2.elevation
        ),
        border = BorderStroke(1.dp, MaterialTheme.colorScheme.outline),
        modifier = Modifier
            .fillMaxWidth()
            .heightIn(min = 200.dp)
    ) {
        Column(
            modifier = Modifier
                .fillMaxWidth()
                .padding(AppTokens.Spacing.lg),
            verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.md),
            horizontalAlignment = Alignment.Start
        ) {
            Box(
                modifier = Modifier
                    .fillMaxWidth()
                    .aspectRatio(1.2f)
                    .background(p.color, shape = AppTokens.Shapes.medium),
                contentAlignment = Alignment.Center
            ) {
                Text(
                    text = "Image",
                    style = MaterialTheme.typography.labelMedium,
                    color = MaterialTheme.colorScheme.onSurface
                )
            }
            Row(
                modifier = Modifier.fillMaxWidth(),
                horizontalArrangement = Arrangement.SpaceBetween,
                verticalAlignment = Alignment.CenterVertically
            ) {
                Text(
                    text = p.title,
                    style = MaterialTheme.typography.titleMedium,
                    color = MaterialTheme.colorScheme.onSurface
                )
                if (p.badge.isNotEmpty()) {
                    Box(
                        modifier = Modifier
                            .background(MaterialTheme.colorScheme.tertiary, shape = AppTokens.Shapes.small)
                            .padding(horizontal = AppTokens.Spacing.sm, vertical = AppTokens.Spacing.xs),
                        contentAlignment = Alignment.Center
                    ) {
                        Text(
                            text = p.badge,
                            style = MaterialTheme.typography.labelMedium,
                            color = MaterialTheme.colorScheme.onTertiary
                        )
                    }
                }
            }
            Text(
                text = p.price,
                style = MaterialTheme.typography.headlineMedium,
                color = MaterialTheme.colorScheme.primary
            )
            Row(
                verticalAlignment = Alignment.CenterVertically,
                horizontalArrangement = Arrangement.Start
            ) {
                Box(
                    modifier = Modifier
                        .size(10.dp, 10.dp)
                        .background(AppTokens.Colors.warning, shape = AppTokens.Shapes.small)
                )
                Spacer(modifier = Modifier.width(AppTokens.Spacing.sm))
                Text(
                    text = "${p.rating} rating",
                    style = MaterialTheme.typography.bodyMedium,
                    color = MaterialTheme.colorScheme.onSurface
                )
            }
            Button(
                onClick = {},
                colors = ButtonDefaults.buttonColors(
                    containerColor = MaterialTheme.colorScheme.primary,
                    contentColor = MaterialTheme.colorScheme.onPrimary
                ),
                shape = AppTokens.Shapes.medium,
                modifier = Modifier
                    .fillMaxWidth()
                    .height(40.dp)
            ) {
                Text(
                    text = "Add to Cart",
                    style = MaterialTheme.typography.titleMedium
                )
            }
        }
    }
}

@Composable
fun BottomActionBar(subtotal: String, actionLabel: String, onAction: () -> Unit) {
    Surface(
        color = MaterialTheme.colorScheme.surface,
        tonalElevation = AppTokens.ElevationMapping.level3.elevation,
        shadowElevation = AppTokens.ElevationMapping.level3.elevation
    ) {
        Row(
            modifier = Modifier
                .fillMaxWidth()
                .padding(horizontal = AppTokens.Spacing.lg, vertical = AppTokens.Spacing.md),
            horizontalArrangement = Arrangement.SpaceBetween,
            verticalAlignment = Alignment.CenterVertically
        ) {
            Column(
                verticalArrangement = Arrangement.spacedBy(AppTokens.Spacing.xs),
                horizontalAlignment = Alignment.Start
            ) {
                Text(
                    text = "Subtotal",
                    style = MaterialTheme.typography.labelMedium,
                    color = MaterialTheme.colorScheme.onSurface
                )
                Text(
                    text = subtotal,
                    style = MaterialTheme.typography.headlineMedium,
                    color = MaterialTheme.colorScheme.onSurface
                )
            }
            Button(
                onClick = onAction,
                colors = ButtonDefaults.buttonColors(
                    containerColor = MaterialTheme.colorScheme.secondary,
                    contentColor = MaterialTheme.colorScheme.onSecondary
                ),
                shape = AppTokens.Shapes.large,
                modifier = Modifier
                    .height(44.dp)
                    .width(140.dp)
            ) {
                Text(text = actionLabel, style = MaterialTheme.typography.titleMedium)
            }
        }
    }
}

class MainActivity : ComponentActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        WindowCompat.setDecorFitsSystemWindows(window, false)
        val controller = WindowInsetsControllerCompat(window, window.decorView)
        controller.systemBarsBehavior =
            WindowInsetsControllerCompat.BEHAVIOR_SHOW_TRANSIENT_BARS_BY_SWIPE
        controller.hide(WindowInsetsCompat.Type.navigationBars())

        setContent {
            AppTheme {
                Surface(color = MaterialTheme.colorScheme.background) {
                    RootScreen()
                }
            }
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