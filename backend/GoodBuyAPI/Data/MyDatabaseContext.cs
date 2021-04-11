using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using Microsoft.EntityFrameworkCore;

namespace GoodBuyAPI.Models
{
    public class MyDatabaseContext : DbContext
    {
        public MyDatabaseContext(DbContextOptions<MyDatabaseContext> options)
            : base(options)
        {
        }

        public DbSet<GoodBuyAPI.Models.Entry> EntriesList { get; set; }

        protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
        {
            optionsBuilder.EnableSensitiveDataLogging();
        }

        // Initially used to transfer entries from Excel to database.
        // Tool is also implemented in the solution.
        #region initialData

//        protected override void OnModelCreating(ModelBuilder modelBuilder)
//        {

//            var review = new Entry[]
//{
//                new Entry
//                {
//                    ID = 8600742014093, Name = "Брынза сербская \\\"Сербский дом\\\"",
//                    Link = "https://otzovik.com/reviews/brinza_serbskaya_serbskiy_dom/"
//                },
//                new Entry
//                {
//                    ID = 4607052403818, Name = "Палочки моцареллы Умалат \\\"Бонджорно\\\"",
//                    Link = "https://otzovik.com/reviews/palochki_mocarelli_umalat_bondzhorno/"
//                },
//                new Entry
//                {
//                    ID = 4680016940018, Name = "Сыр Моцарелла Егорлык молоко Mini",
//                    Link = "https://otzovik.com/reviews/sir_mocarella_egorlik_moloko_mini/"
//                },
//                new Entry
//                {
//                    ID = 2313059002900, Name = "Адыгейский сыр \\\"Молкомбинат Адыгейский\\\"",
//                    Link = "https://otzovik.com/reviews/adigeyskiy_sir_molkombinat_adigeyskiy/"
//                },
//                new Entry
//                {
//                    ID = 4770299390583, Name = "Сыр твердый жирный Dziugas",
//                    Link = "https://otzovik.com/reviews/sir_tverdiy_zhirniy_dziugas/"
//                },
//                new Entry
//                {
//                    ID = 4620770400723, Name = "Сыр Красногвардейский молочный завод \\\"Адыгейский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_krasnogvardeyskiy_molochniy_zavod_adigeyskiy/"
//                },
//                new Entry
//                {
//                    ID = 4607052403702, Name = "Сыр моцарелла без лактозы для сэндвичей Umalat Mozzarella Unagrande",
//                    Link =
//                        "https://otzovik.com/reviews/sir_mocarella_bez_laktozi_dlya_sendvichey_umalat_mozzarella_unagrande/"
//                },
//                new Entry
//                {
//                    ID = 4607048553763, Name = "Сыр мягкий Сыр Село Зеленое \\\"Фермерский завтрак\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_sir_selo_zelenoe_fermerskiy_zavtrak/"
//                },
//                new Entry
//                {
//                    ID = 5900512220000, Name = "Творог Mlekovita \\\"Гануси\\\" 6,5%",
//                    Link = "https://otzovik.com/reviews/sir_kislomolochniy_mlekovita_ganusi/"
//                },
//                new Entry
//                {
//                    ID = 4690363076765, Name = "Сыр Ашан \\\"Рикотта\\\"",
//                    Link = "https://otzovik.com/reviews/sir_ashan_rikotta/"
//                },
//                new Entry
//                {
//                    ID = 4900512190408, Name = "Сыр Swiatowid \\\"Гауда\\\"",
//                    Link = "https://otzovik.com/reviews/sir_swiatowid_gauda/"
//                },
//                new Entry
//                {
//                    ID = 4607127280221, Name = "Сыр ИП Агамирян В.С. \\\"Сулугуни\\\"",
//                    Link = "https://otzovik.com/reviews/sir_ip_agamiryan_v_s_suluguni/"
//                },
//                new Entry
//                {
//                    ID = 4823061315588, Name = "Сыр кисломолочный Ромол 9, 0%",
//                    Link = "https://otzovik.com/reviews/sir_kislomolochniy_romol_9_0/"
//                },
//                new Entry
//                {
//                    ID = 3073780979528, Name = "Сыр Leerdammer \\\"Original\\\"",
//                    Link = "https://otzovik.com/reviews/sir_leerdammer_original/"
//                },
//                new Entry
//                {
//                    ID = 8011661001345, Name = "Сыр Trentin Grana Padano",
//                    Link = "https://otzovik.com/reviews/sir_trentin_grana_padano/"
//                },
//                new Entry
//                {
//                    ID = 4607048552339, Name = "Сыр Сулугуни Калория \\\"Из старой деревни\\\"",
//                    Link = "https://otzovik.com/reviews/sir_suluguni_kaloriya_iz_staroy_derevni/"
//                },
//                new Entry
//                {
//                    ID = 4607052403436, Name = "Палочки Умалат \\\"Сулугуни\\\"",
//                    Link = "https://otzovik.com/reviews/palochki_umalat_suluguni/"
//                },
//                new Entry
//                {
//                    ID = 4011410690107, Name = "Сыр Bellezza \\\"Моцарелла\\\"",
//                    Link = "https://otzovik.com/reviews/sir_bellezza_mocarella/"
//                },
//                new Entry
//                {
//                    ID = 4630073930025, Name = "Сыр Laime Switzerland Swiss Cheese",
//                    Link = "https://otzovik.com/reviews/sir_laime_switzerland_swiss_cheese/"
//                },
//                new Entry
//                {
//                    ID = 4630055991136, Name = "Сыр полутвердый Ферма Долюбово \\\"Российский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_polutverdiy_ferma_dolyubovo_rossiyskiy/"
//                },
//                new Entry
//                {
//                    ID = 8002004437259, Name = "Сыр Biraghi Пармезан Biraghini Snack",
//                    Link = "https://otzovik.com/reviews/sir_biraghi_parmezan_biraghini_snack/"
//                },
//                new Entry
//                {
//                    ID = 2100100162924, Name = "Сыр ВкусВилл \\\"Моцарелла перлини\\\"",
//                    Link = "https://otzovik.com/reviews/sir_vkusvill_mocarella_perlini/"
//                },
//                new Entry
//                {
//                    ID = 4606068330194, Name = "Сыр Лента Адыгейский копченый",
//                    Link = "https://otzovik.com/reviews/sir_lenta_adigeyskiy_kopcheniy/"
//                },
//                new Entry
//                {
//                    ID = 2341573002267, Name = "Сыр Арча \\\"Гауда\\\"",
//                    Link = "https://otzovik.com/reviews/sir_archa_gauda/"
//                },
//                new Entry
//                {
//                    ID = 4607028304712, Name = "Сыр Ровеньки-маслосырзавод Fresh",
//                    Link = "https://otzovik.com/reviews/sir_rovenki-maslosirzavod_fresh/"
//                },
//                new Entry
//                {
//                    ID = 2100100159139, Name = "Сыр мягкий ВкусВилл \\\"Рикотта с шоколадом\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_vkusvill_rikotta_s_shokoladom/"
//                },
//                new Entry
//                {
//                    ID = 4680320008205, Name = "Сыр фасованный тертый Milken Mite для пиццы",
//                    Link = "https://otzovik.com/reviews/sir_fasovanniy_tertiy_milken_mite_dlya_picci/"
//                },
//                new Entry
//                {
//                    ID = 5703985070383, Name = "Сыр с голубой плесенью Danablu Mammen OST",
//                    Link = "https://otzovik.com/reviews/sir_s_goluboy_plesenyu_danablu_mammen_ost/"
//                },
//                new Entry
//                {
//                    ID = 465011743020, Name = "Сыр Алтайские сыровары \\\"Голландский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_altayskie_sirovari_gollandskiy/"
//                },
//                new Entry
//                {
//                    ID = 4610032580072, Name = "Сыр Николаевские сыроварни \\\"Костромской\\\"",
//                    Link = "https://otzovik.com/reviews/sir_nikolaevskie_sirovarni_kostromskoy/"
//                },
//                new Entry
//                {
//                    ID = 4607052402880, Name = "Сыр Маркет Перекресток \\\"Сулугуни\\\"",
//                    Link = "https://otzovik.com/reviews/sir_market_perekrestok_suluguni/"
//                },
//                new Entry
//                {
//                    ID = 4601363002241, Name = "Сыр Скит \\\"Скармоца Чьельджине\\\" копченый",
//                    Link = "https://otzovik.com/reviews/sir_skit_skarmoca_cheldzhine_kopcheniy/"
//                },
//                new Entry
//                {
//                    ID = 4779024794696, Name = "Продукт веганский Regalio с зеленью",
//                    Link = "https://otzovik.com/reviews/produkt_veganskiy_regalio_s_zelenyu/"
//                },
//                new Entry
//                {
//                    ID = 20532031, Name = "Сыр Antichi Maestri Parmigiano Reggiano DOP",
//                    Link = "https://otzovik.com/reviews/sir_antichi_maestri_parmigiano_reggiano_dop/gallery/"
//                },
//                new Entry
//                {
//                    ID = 4610004671449, Name = "Сыр Сармич \\\"Чеддер\\\"",
//                    Link = "https://otzovik.com/reviews/sir_sarmich_chedder/"
//                },
//                new Entry
//                {
//                    ID = 20536718, Name = "Сыр Pilos Camembert натуральный",
//                    Link = "https://otzovik.com/reviews/sir_pilos_camembert_naturalniy/"
//                },
//                new Entry
//                {
//                    ID = 2546953003487, Name = "Сыр Белослава \\\"Сырный аристократ\\\" 50%",
//                    Link = "https://otzovik.com/reviews/sir_beloslava_sirniy_aristokrat_50_vesovoy/gallery/"
//                },
//                new Entry
//                {
//                    ID = 2100100004163, Name = "Сыр Избенка \\\"Гран-При\\\"",
//                    Link = "https://otzovik.com/reviews/sir_izbenka_gran-pri/"
//                },
//                new Entry
//                {
//                    ID = 4607195114022, Name = "Сыр Чабан \\\"Сулугуни\\\"",
//                    Link = "https://otzovik.com/reviews/sir_chaban_suluguni/"
//                },
//                new Entry
//                {
//                    ID = 2510348003581, Name = "Сыр мягкий сливочный ХолиФуд \\\"Чезария\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_slivochniy_holifud_chezariya/"
//                },
//                new Entry
//                {
//                    ID = 4607052402217, Name = "Сыр Ваш выбор \\\"Моцарелла мини\\\"",
//                    Link = "https://otzovik.com/reviews/sir_vash_vibor_mocarella_mini/"
//                },
//                new Entry
//                {
//                    ID = 5901390002672, Name = "Сыр Delikate Blue niebieski",
//                    Link = "https://otzovik.com/reviews/sir_delikate_blue_niebieski/"
//                },
//                new Entry
//                {
//                    ID = 20982218, Name = "Сыр Bluedino Gauda", Link = "https://otzovik.com/reviews/sir_bluedino_gauda/"
//                },
//                new Entry
//                {
//                    ID = 4607966161170, Name = "Сыр Красногвардейский Молочный завод \\\"Ассорти\\\"",
//                    Link = "https://otzovik.com/reviews/sir_krasnogvardeyskiy_molochniy_zavod_assorti/"
//                },
//                new Entry
//                {
//                    ID = 4640001731143, Name = "Сыр Viola плавленый \\\"Ветчина и пармезан\\\"",
//                    Link = "https://otzovik.com/reviews/sir_viola_plavleniy_vetchina_i_parmezan/"
//                },
//                new Entry
//                {
//                    ID = 2370645003109, Name = "Сыр Починки \\\"Гауда Починки\\\"",
//                    Link = "https://otzovik.com/reviews/sir_pochinki_gauda_pochinki/"
//                },
//                new Entry
//                {
//                    ID = 8594015246956, Name = "Балканский сыр в рассоле Balsyr",
//                    Link = "https://otzovik.com/reviews/balkanskiy_sir_v_rassole_balsyr/"
//                },
//                new Entry
//                {
//                    ID = 4607003722715, Name = "Сыр домашний мягкий Melike с тмином",
//                    Link = "https://otzovik.com/reviews/sir_domashniy_myagkiy_melike_s_tminom/"
//                },
//                new Entry
//                {
//                    ID = 4607908056538, Name = "Сыр Il Primo Gusto \\\"Моцарелла\\\"",
//                    Link = "https://otzovik.com/reviews/sir_il_primo_gusto_mocarella/"
//                },
//                new Entry
//                {
//                    ID = 8600742011658, Name = "Сербский сыр Mlekara Subotica Брынза",
//                    Link = "https://otzovik.com/reviews/serbskiy_sir_mlekara_subotica_brinza/"
//                },
//                new Entry
//                {
//                    ID = 4640001731761, Name = "Сыр полутвердый фасованный Valio \\\"Бутербродный\\\"",
//                    Link = "https://otzovik.com/reviews/sir_polutverdiy_fasovanniy_valio_buterbrodniy/"
//                },
//                new Entry
//                {
//                    ID = 6414893381087, Name = "Сыр Epiim \\\"Kermaguusto\\\" эстонский сливочный",
//                    Link = "https://otzovik.com/reviews/sir_epiim_kermaguusto_estonskiy_slivochniy/"
//                },
//                new Entry
//                {
//                    ID = 56058663, Name = "Сыр Swiatowid \\\"Liliput\\\"",
//                    Link = "https://otzovik.com/reviews/sir_swiatowid_liliput/"
//                },
//                new Entry
//                {
//                    ID = 2877089003585, Name = "Мягкий сыр Ermitage \\\"Бри\\\"",
//                    Link = "https://otzovik.com/reviews/myagkiy_sir_ermitage_bri/"
//                },
//                new Entry
//                {
//                    ID = 4607052401401, Name = "Сыр Mozzarella для пиццы \\\"Pretto\\\"",
//                    Link = "https://otzovik.com/reviews/sir_mozzarella_dlya_pizza_pretto/"
//                },
//                new Entry
//                {
//                    ID = 4607070735809, Name = "Сыр Белебеевский \\\"Белебеевский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_belebeevskiy_belebeevskiy/"
//                },
//                new Entry
//                {
//                    ID = 4607052403689,
//                    Name = "Сыр Mozzarella Unagrande Ciliegine Senza Lattosio маленькие шарики без лактозы",
//                    Link =
//                        "https://otzovik.com/reviews/sir_mozzarella_unagrande_ciliegine_senza_lattosio_malenkie_shariki_bez_laktozi/"
//                },
//                new Entry
//                {
//                    ID = 8606003752728, Name = "Сыр мягкий Kuc-Company Сербский каймак",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_kuc-company_serbskiy_kaymak/"
//                },
//                new Entry
//                {
//                    ID = 230043002240, Name = "Сыр Томмолоко \\\"Легенда Алтая\\\"",
//                    Link = "https://otzovik.com/reviews/sir_tommoloko_legenda_altaya/"
//                },
//                new Entry
//                {
//                    ID = 4607108092751, Name = "Сыр Cheezzi Чизано с пажитником",
//                    Link = "https://otzovik.com/reviews/sir_cheezzi_chizano_s_pazhitnikom/"
//                },
//                new Entry
//                {
//                    ID = 607059883002, Name = "Сыр Ичалки \\\"Мраморный\\\"",
//                    Link = "https://otzovik.com/reviews/sir_ichalki_mramorniy/"
//                },
//                new Entry
//                {
//                    ID = 2507642005724, Name = "Сыр Frico \\\"Маасдам\\\"",
//                    Link = "https://otzovik.com/reviews/sir_frico_maasdam/"
//                },
//                new Entry
//                {
//                    ID = 4607052401357, Name = "Сыр Ungrande Маскарпоне гастрономический",
//                    Link = "https://otzovik.com/reviews/sir_ungrande_maskarpone_gastronomicheskiy/"
//                },
//                new Entry
//                {
//                    ID = 2217440002480, Name = "Сыр OGreen \\\"Адыгейский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_o_green_adigeyskiy/"
//                },
//                new Entry
//                {
//                    ID = 2737695004904, Name = "Сыр Славия \\\"Сулугуни\\\"",
//                    Link = "https://otzovik.com/reviews/sir_slaviya_suluguni/"
//                },
//                new Entry
//                {
//                    ID = 9263575612622, Name = "Сыр Добряна \\\"Качиотто\\\"",
//                    Link = "https://otzovik.com/reviews/sir_dobryana_kachiotto/"
//                },
//                new Entry
//                {
//                    ID = 7038010028885, Name = "Сыр TINE Norway Gudbrandsdalen",
//                    Link = "https://otzovik.com/reviews/sir_tine_norway_gudbrandsdalen/"
//                },
//                new Entry
//                {
//                    ID = 4606068277529, Name = "Сыр Лента \\\"Сулугуни\\\"",
//                    Link = "https://otzovik.com/reviews/sir_lenta_suluguni/"
//                },
//                new Entry
//                {
//                    ID = 2773473002083, Name = "Сыр твердый Пирятин \\\"Ореховый\\\" 50%",
//                    Link = "https://otzovik.com/reviews/sir_tverdiy_piryatin_orehoviy_50/"
//                },
//                new Entry
//                {
//                    ID = 2701786002667, Name = "Сыр Новгород-Северский сырзавод \\\"Рафаэль\\\"",
//                    Link = "https://otzovik.com/reviews/sir_novgorod-severskiy_sirzavod_rafael/"
//                },
//                new Entry
//                {
//                    ID = 4607024209899, Name = "Сыр мягкий Стародуб \\\"Кавказский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_starodub_kavkazskiy/?&capt4a=2"
//                },
//                new Entry
//                {
//                    ID = 4607048552957, Name = "Сыр Кезский сырзавод \\\"Сливочный\\\"",
//                    Link = "https://otzovik.com/reviews/sir_kezskiy_sirzavod_slivochniy/"
//                },
//                new Entry
//                {
//                    ID = 4740572005053, Name = "Сыр Estover piimatoostus \\\"Hiirte Juust",
//                    Link = "https://otzovik.com/reviews/sir_estover_piimatoostus_hiirte_juust/"
//                },
//                new Entry
//                {
//                    ID = 4680034320280, Name = "Сыр Ваша ферма \\\"Чечил спагетти\\\"",
//                    Link = "https://otzovik.com/reviews/sir_vasha_ferma_chechil_spagetti/"
//                },
//                new Entry
//                {
//                    ID = 4650068534243, Name = "Сыр сливочный Лукоморье \\\"Шоколадный\\\"",
//                    Link = "https://otzovik.com/reviews/sir_slivochniy_lukomore_shokoladniy/"
//                },
//                new Entry
//                {
//                    ID = 2907450010352, Name = "Сыр Le Superbe Switzerland Swiss",
//                    Link = "https://otzovik.com/reviews/sir_le_superbe_switzerland_swiss/"
//                },
//                new Entry
//                {
//                    ID = 5902208000804, Name = "Сыр Ryki Цезарь", Link = "https://otzovik.com/reviews/sir_ryki_cezar/"
//                },
//                new Entry
//                {
//                    ID = 2100100072599, Name = "Сыр ВкусВилл \\\"Качокавалло\\\"",
//                    Link = "https://otzovik.com/reviews/sir_vkusvill_kachokavallo/"
//                },
//                new Entry
//                {
//                    ID = 4810557000783,
//                    Name = "Сыр Березовский сыродельный комбинат \\\"Беловежский\\\" копченый с перцем и чесноком",
//                    Link =
//                        "https://otzovik.com/reviews/sir_berezovskiy_sirodelniy_kombinat_belovezhskiy_kopcheniy_s_percem_i_chesnokom/"
//                },
//                new Entry
//                {
//                    ID = 4630032360429, Name = "Сыр мягкий Сырная Гильдия \\\"Камамбер\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_sirnaya_gildiya_kamamber/"
//                },
//                new Entry
//                {
//                    ID = 2100100082925, Name = "Сыр мягкий \\\"Избенка\\\" Бюш де фамиль с белой плесенью",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_izbenka_byush_de_famil_s_beloy_plesenyu/"
//                },
//                new Entry
//                {
//                    ID = 4607007644457, Name = "Сыр Великолукский молочный комбинат Чеддер красный",
//                    Link = "https://otzovik.com/reviews/sir_velikolukskiy_molochniy_kombinat_chedder_krasniy/"
//                },
//                new Entry
//                {
//                    ID = 4002174205379, Name = "Швейцарский сыр Margot Fromages Sa Tete de Moine",
//                    Link = "https://otzovik.com/reviews/shveycarskiy_sir_margot_fromages_sa_tete_de_moine/"
//                },
//                new Entry
//                {
//                    ID = 3161712996146, Name = "Сыр ILE de Franse Petit Brie",
//                    Link = "https://otzovik.com/reviews/sir_ile_de_franse_petit_brie/"
//                },
//                new Entry
//                {
//                    ID = 4811832000795, Name = "Сыр копченый Глубокская птицефабрика \\\"Джил\\\"",
//                    Link = "https://otzovik.com/reviews/sir_kopcheniy_glubokskaya_pticefabrika_dzhil/"
//                },
//                new Entry
//                {
//                    ID = 7610563606392, Name = "Сыр Le Superbe Services AG \\\"Lustenberger 1862 fruity tangy\\\"",
//                    Link = "https://otzovik.com/reviews/sir_le_superbe_services_ag_lustenberger_1862_fruity_tangy/"
//                },
//                new Entry
//                {
//                    ID = 2104779003403, Name = "Сыр Холод \\\"Адыгейский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_holod_adigeyskiy/"
//                },
//                new Entry
//                {
//                    ID = 4607044667426, Name = "Сыр сухой копченый Фома Лукич \\\"Бочонок\\\"",
//                    Link = "https://otzovik.com/reviews/sir_suhoy_kopcheniy_foma_lukich_bochonok/"
//                },
//                new Entry
//                {
//                    ID = 5900120061729, Name = "Сыр Swiatowid Salami",
//                    Link = "https://otzovik.com/reviews/sir_swiatowid_salami/"
//                },
//                new Entry
//                {
//                    ID = 4700000140053, Name = "Колбасный сыр \\\"Беловодский маслосырзавод\\\"",
//                    Link = "https://otzovik.com/reviews/kolbasniy_sir_belovodskiy_maslosirzavod/"
//                },
//                new Entry
//                {
//                    ID = 2000063640012, Name = "Сыр для жарки МясновЪ \\\"Сернурский Халумис\\\"",
//                    Link = "https://otzovik.com/reviews/sir_dlya_zharki_myasnov_sernurskiy_halumis/"
//                },
//                new Entry
//                {
//                    ID = 4810904000480, Name = "Сыр Кувшинка \\\"Сулугуни\\\"",
//                    Link = "https://otzovik.com/reviews/sir_kuvshinka_suluguni/"
//                },
//                new Entry
//                {
//                    ID = 4810012003106, Name = "Сыр Новогрудские дары \\\"Адыгейский классический\\\"",
//                    Link = "https://otzovik.com/reviews/sir_novogrudskie_dari_adigeyskiy_klassicheskiy/"
//                },
//                new Entry
//                {
//                    ID = 4627128150040, Name = "Соевый сыр Едемский сад \\\"Тофу\\\"",
//                    Link = "https://otzovik.com/reviews/soeviy_sir_edemskiy_sad_tofu/"
//                },
//                new Entry
//                {
//                    ID = 4740553698113, Name = "Сыр пармезан Valio Forte",
//                    Link = "https://otzovik.com/reviews/sir_parmezan_valio_forte/"
//                },
//                new Entry
//                {
//                    ID = 7640106051211, Name = "Сыр мягкий Moser Schweizer Huus Chasli Хуус Часли с белой плесенью",
//                    Link =
//                        "https://otzovik.com/reviews/sir_myagkiy_moser_schweizer_huus_chasli_huus_chasli_s_beloy_plesenyu/"
//                },
//                new Entry
//                {
//                    ID = 8021398443905, Name = "Сыр Igor Gorgonzola Piccante",
//                    Link = "https://otzovik.com/reviews/sir_igor_gorgonzola_piccante/"
//                },
//                new Entry
//                {
//                    ID = 4607141170720, Name = "Сыр с пажитником Продукты из Ярославки \\\"Молога\\\"",
//                    Link = "https://otzovik.com/reviews/sir_s_pazhitnikom_produkti_iz_yaroslavki_mologa/"
//                },
//                new Entry
//                {
//                    ID = 4607022663242, Name = "Сыр President La Brique",
//                    Link = "https://otzovik.com/reviews/sir_president_la_brique/"
//                },
//                new Entry
//                {
//                    ID = 7617067036328, Name = "Сыр Haidi Swiss Ceddar",
//                    Link = "https://otzovik.com/reviews/sir_haidi_swiss_ceddar/"
//                },
//                new Entry
//                {
//                    ID = 4607025501992, Name = "Сыр мягкий Шекснинский маслозавод \\\"Адыгейский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_sheksninskiy_maslozavod_adigeyskiy/"
//                },
//                new Entry
//                {
//                    ID = 4820009352636, Name = "Сыр твердый Звени Гора Фигура",
//                    Link = "https://otzovik.com/reviews/sir_tverdiy_zveni_gora_figura/"
//                },
//                new Entry
//                {
//                    ID = 40409801, Name = "Сыр с голубой плесенью Paladin \\\"Fromage bleu\\\"",
//                    Link = "https://otzovik.com/reviews/sir_s_goluboy_plesenyu_paladin_fromage_bleu/"
//                },
//                new Entry
//                {
//                    ID = 4740142003786, Name = "Сыр Epiim Edamjuusto",
//                    Link = "https://otzovik.com/reviews/sir_epiim_edamjuusto/"
//                },
//                new Entry
//                {
//                    ID = 5900512130408, Name = "Твердый сыр Biedronka Serovit Gouda",
//                    Link = "https://otzovik.com/reviews/tverdiy_sir_biedronka_serovit_gouda/"
//                },
//                new Entry
//                {
//                    ID = 2000000000626, Name = "Сыр Подворье \\\"Моцарелла\\\"",
//                    Link = "https://otzovik.com/reviews/sir_podvore_mocarella/"
//                },
//                new Entry
//                {
//                    ID = 2201956900545, Name = "Сыр Cheese Life \\\"Mozzarella Pizza\\\"",
//                    Link = "https://otzovik.com/reviews/sir_cheese_life_mozzarella_pizza/"
//                },
//                new Entry
//                {
//                    ID = 8004603100381, Name = "Сыр Antichi Maestri \\\"Grana Padano\\\"",
//                    Link = "https://otzovik.com/reviews/sir_antichi_maestri_grana_padano/"
//                },
//                new Entry
//                {
//                    ID = 4607074392442, Name = "Сыр Zorka \\\"Адыгейский деликатесный\\\"",
//                    Link = "https://otzovik.com/reviews/sir_zorka_adigeyskiy_delikatesniy/"
//                },
//                new Entry
//                {
//                    ID = 4607946840439, Name = "Сыр Здоровье из Предгорья \\\"Фермерский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_zdorove_iz_predgorya_fermerskiy/"
//                },
//                new Entry
//                {
//                    ID = 3523230028431, Name = "Сыр козий Soignon",
//                    Link = "https://otzovik.com/reviews/sir_koziy_soignon/"
//                },
//                new Entry
//                {
//                    ID = 4820111642359, Name = "Сыр Добряна \\\"Золотистый\\\"",
//                    Link = "https://otzovik.com/reviews/sir_dobryana_zolotistiy/"
//                },
//                new Entry
//                {
//                    ID = 20933883, Name = "Сыр Milbona Маасдам финский",
//                    Link = "https://otzovik.com/reviews/sir_milbona_maasdam_finskiy/"
//                },
//                new Entry {ID = 20014254, Name = "Сыр Milbona", Link = "https://otzovik.com/reviews/sir_milbona/"},
//                new Entry
//                {
//                    ID = 2310369000930, Name = "Сыр Новогрудские Дары \\\"Песто\\\"",
//                    Link = "https://otzovik.com/reviews/sir_novogrudskie_dari_pesto/"
//                },
//                new Entry
//                {
//                    ID = 8692971434919, Name = "Сыр турецкий Halk Taze Kasar Peyniri",
//                    Link = "https://otzovik.com/reviews/sir_tureckiy_halk_taze_kasar_peyniri/"
//                },
//                new Entry
//                {
//                    ID = 4607127280054, Name = "Сыр мягкий Ровеньки \\\"Адыгейский\\\" 45%",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_rovenki_adigeyskiy_45/"
//                },
//                new Entry
//                {
//                    ID = 5760466827225, Name = "Сыр с голубой плесенью Castello Danish Blue \\\"Сливочный\\\"",
//                    Link = "https://otzovik.com/reviews/sir_s_goluboy_plesenyu_castello_danish_blue_slivochniy/"
//                },
//                new Entry
//                {
//                    ID = 3073781053821, Name = "Сыр Leerdammer Llightlife 17%",
//                    Link = "https://otzovik.com/reviews/sir_leerdammer_llightlife_17/"
//                },
//                new Entry
//                {
//                    ID = 6408432052705, Name = "Копченый сыр Viola с салями",
//                    Link = "https://otzovik.com/reviews/kopcheniy_sir_viola_s_salyami/"
//                },
//                new Entry
//                {
//                    ID = 3272770003148, Name = "Свежий сыр из козьего молока Bongrain \\\"Chavroux\\\"",
//                    Link = "https://otzovik.com/reviews/svezhiy_sir_iz_kozego_moloka_bongrain_chavroux/"
//                },
//                new Entry
//                {
//                    ID = 4606068378707, Name = "Сыр Лента \\\"Фермерский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_lenta_fermerskiy/"
//                },
//                new Entry
//                {
//                    ID = 2393876003304, Name = "Сыр LiebenDorf Маасдам",
//                    Link = "https://otzovik.com/reviews/sir_liebendorf_maasdam/?&capt4a=2"
//                },
//                new Entry
//                {
//                    ID = 4650100420497, Name = "Сыр с белой плесенью Жуковское молоко Camambert from Zhukovka",
//                    Link = "https://otzovik.com/reviews/sir_s_beloy_plesenyu_zhukovskoe_moloko_camambert_from_zhukovka/"
//                },
//                new Entry
//                {
//                    ID = 4607052402378, Name = "Мягкий сыр Pretto \\\"Маскарпоне\\\"",
//                    Link = "https://otzovik.com/reviews/myagkiy_sir_pretto_maskarpone/"
//                },
//                new Entry
//                {
//                    ID = 2844830000629, Name = "Сыр Mifroma Sa \\\"Тет де Муан\\\"",
//                    Link = "https://otzovik.com/reviews/sir_mifroma_sa_tet_de_muan/"
//                },
//                new Entry
//                {
//                    ID = 4607052401302, Name = "Сыр Unagrande \\\"Моцарелла Чильеджина\\\"",
//                    Link = "https://otzovik.com/reviews/sir_unagrande_mocarella_chiledzhina/gallery/"
//                },
//                new Entry
//                {
//                    ID = 4680038890376, Name = "Сыр мягкий Сливкин дом \\\"Рикотта\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_slivkin_dom_rikotta/"
//                },
//                new Entry
//                {
//                    ID = 4650167850336, Name = "Сыр Белое Золото Адыгейский из Козьего молока",
//                    Link = "https://otzovik.com/reviews/sir_beloe_zoloto_adigeyskiy_iz_kozego_moloka/"
//                },
//                new Entry
//                {
//                    ID = 4607002022618, Name = "Сыр Violife \\\"Легкий\\\"",
//                    Link = "https://otzovik.com/reviews/sir_violife_legkiy/"
//                },
//                new Entry
//                {
//                    ID = 4660059528045, Name = "Сыр Фермерская коллекция \\\"Рикотта\\\" 45%",
//                    Link = "https://otzovik.com/reviews/sir_fermerskaya_kollekciya_rikotta_45/"
//                },
//                new Entry
//                {
//                    ID = 2999200013669, Name = "Сыр De Luxe Maasdam",
//                    Link = "https://otzovik.com/reviews/sir_de_luxe_maasdam/"
//                },
//                new Entry
//                {
//                    ID = 4607128362391, Name = "Сыр ОКей Домашний по-кавказски",
//                    Link = "https://otzovik.com/reviews/sir_o_key_domashniy_po-kavkazski/"
//                },
//                new Entry
//                {
//                    ID = 4610032582106, Name = "Сыр Николаевские сыроварни \\\"Мягкий\\\" фермерский",
//                    Link = "https://otzovik.com/reviews/sir_nikolaevskie_sirovarni_myagkiy_fermerskiy/"
//                },
//                new Entry
//                {
//                    ID = 2787241003424, Name = "Сыр Пирятин \\\"Мраморный\\\"",
//                    Link = "https://otzovik.com/reviews/sir_piryatin_mramorniy/"
//                },
//                new Entry
//                {
//                    ID = 5900512990224, Name = "Сыр Mlekovita Salami",
//                    Link = "https://otzovik.com/reviews/sir_mlekovita_salami/"
//                },
//                new Entry
//                {
//                    ID = 2100100030582, Name = "Тофу ВкусВилл \\\"С укропом и чесноком\\\"",
//                    Link = "https://otzovik.com/reviews/tofu_vkusvill_s_ukropom_i_chesnokom/"
//                },
//                new Entry
//                {
//                    ID = 4606038038891, Name = "Сыр мягкий Зеленая Линия с томатом и базиликом",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_zelenaya_liniya_s_tomatom_i_bazilikom/"
//                },
//                new Entry
//                {
//                    ID = 4630061740896, Name = "Сыр Джанкойский сыр \\\"Моцарелла\\\"",
//                    Link = "https://otzovik.com/reviews/sir_dzhankoyskiy_sir_mocarella/"
//                },
//                new Entry
//                {
//                    ID = 4607052402392, Name = "Сыр мягкий Unagrande Cacioricotta",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_unagrande_cacioricotta/"
//                },
//                new Entry
//                {
//                    ID = 2100100102951, Name = "Сыр ВкусВилл \\\"Сбринц\\\"",
//                    Link = "https://otzovik.com/reviews/sir_vkusvill_sbrinc/"
//                },
//                new Entry
//                {
//                    ID = 2000243003101, Name = "Сыр Радость вкуса \\\"Рыжий Чеддер\\\"",
//                    Link = "https://otzovik.com/reviews/sir_radost_vkusa_rizhiy_chedder/"
//                },
//                new Entry
//                {
//                    ID = 4810904001418, Name = "Сыр Landers \\\"Сулугуни\\\"",
//                    Link = "https://otzovik.com/reviews/sir_landers_suluguni/"
//                },
//                new Entry
//                {
//                    ID = 4665296191991, Name = "Сыр с белой плесенью Fratelli Spirini Монблан",
//                    Link = "https://otzovik.com/reviews/sir_s_beloy_plesenyu_fratelli_spirini_monblan/"
//                },
//                new Entry
//                {
//                    ID = 4620016651018, Name = "Сыр Перекресток Моцарелла для пиццы",
//                    Link = "https://otzovik.com/reviews/sir_perekrestok_mocarella_dlya_picci/"
//                },
//                new Entry
//                {
//                    ID = 4620016651032, Name = "Сыр Маркет Перекресток \\\"Камамбер\\\"",
//                    Link = "https://otzovik.com/reviews/sir_market_perekrestok_kamamber/"
//                },
//                new Entry
//                {
//                    ID = 2100100005481, Name = "Сыр Избенка \\\"Голландский\\\"",
//                    Link = "https://otzovik.com/reviews/sir_izbenka_gollandskiy/"
//                },
//                new Entry
//                {
//                    ID = 8023951002550, Name = "Сыр Ghidetti \\\"Маскарпоне\\\"",
//                    Link = "https://otzovik.com/reviews/sir_ghidetti_maskarpone/"
//                },
//                new Entry
//                {
//                    ID = 5902241216798, Name = "Сыр Makro Chef Ser Camembert",
//                    Link = "https://otzovik.com/reviews/sir_makro_chef_ser_camembert/"
//                },
//                new Entry
//                {
//                    ID = 2100100147600, Name = "Сыр с голубой плесенью Избенка \\\"Джерси Блю\\\"",
//                    Link = "https://otzovik.com/reviews/sir_s_goluboy_plesenyu_izbenka_dzhersi_blyu/"
//                },
//                new Entry
//                {
//                    ID = 4603209002477, Name = "Сыр Рузское молоко \\\"Рузский\\\" Пряный",
//                    Link = "https://otzovik.com/reviews/sir_ruzskoe_moloko_ruzskiy_pryaniy/"
//                },
//                new Entry
//                {
//                    ID = 6402410119556, Name = "Сыр Valio Oltermanni",
//                    Link = "https://otzovik.com/reviews/sir_valio_oltermanni_29/"
//                },
//                new Entry
//                {
//                    ID = 2100100093068, Name = "Сыр мягкий рассольный Избенка Сиртос",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_rassolniy_izbenka_sirtos/"
//                },
//                new Entry
//                {
//                    ID = 4620016650448, Name = "Сыр Маркет Перекресток \\\"Моцарелла\\\"",
//                    Link = "https://otzovik.com/reviews/sir_market_perekrestok_mocarella/"
//                },
//                new Entry
//                {
//                    ID = 6260161533630, Name = "Сливочный сыр Kalleh",
//                    Link = "https://otzovik.com/reviews/slivochniy_sir_kalleh/"
//                },
//                new Entry
//                {
//                    ID = 4000504149423, Name = "Сыр мягкий Kaserei Champignon Cambozola с голубой плесенью",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_kaserei_champignon_cambozola_s_goluboy_plesenyu/"
//                },
//                new Entry
//                {
//                    ID = 2100100073022, Name = "Сыр мягкий ВкусВилл \\\"Бри\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_vkusvill_bri/"
//                },
//                new Entry
//                {
//                    ID = 4520019492598, Name = "Кисломолочный сыр Белоцерковский молокозавод \\\"Домашний\\\"",
//                    Link = "https://otzovik.com/reviews/kislomolochniy_sir_belocerkovskiy_molokozavod_domashniy_5/"
//                },
//                new Entry
//                {
//                    ID = 4607048552919, Name = "Сыр Милком \\\"Тильзитэр\\\"",
//                    Link = "https://otzovik.com/reviews/sir_milkom_tilziter/"
//                },
//                new Entry
//                {
//                    ID = 4740553691152, Name = "Сыр безлактозный Valio \\\"Atleet\\\"",
//                    Link = "https://otzovik.com/reviews/sir_bezlaktozniy_valio_atleet/"
//                },
//                new Entry
//                {
//                    ID = 4627075491061, Name = "Сыр полутвердый Бобровский \\\"Сливочный\\\"",
//                    Link = "https://otzovik.com/reviews/bobrovskiy_sir_polutverdiy_slivochniy/"
//                },
//                new Entry
//                {
//                    ID = 5711953033926, Name = "Сыр Arla Loputon Kermajuusto",
//                    Link = "https://otzovik.com/reviews/sir_arla_loputon_kermajuusto_17/"
//                },
//                new Entry
//                {
//                    ID = 4811233001964, Name = "Сыр мягкий рассольный Молодея \\\"Моцарелла\\\"",
//                    Link = "https://otzovik.com/reviews/sir_myagkiy_rassolniy_molodeya_mocarella/"
//                },
//                new Entry
//                {
//                    ID = 4607050960818, Name = "Сыр копченый косичка Эллазан",
//                    Link = "https://otzovik.com/reviews/sir_kopcheniy_kosichka_ellazan/"
//                },
//                new Entry
//                {
//                    ID = 2370150010241, Name = "Сыр особый Сармич \\\"Гурман\\\" фасованный",
//                    Link = "https://otzovik.com/reviews/sir_osobiy_sarmich_russkiy_sir_fasovanniy/"
//                },
//                new Entry
//                {
//                    ID = 4820040746616, Name = "Сыр кисломолочный Добрыня",
//                    Link = "https://otzovik.com/reviews/sir_kislomolochniy_dobrinya_9/"
//                },
//                new Entry
//                {
//                    ID = 4680046940124, Name = "Сыр для жарки Егорлык Молоко \\\"Халлуме классический\\\"",
//                    Link = "https://otzovik.com/reviews/sir_dlya_zharki_egorlik_moloko_hallume_klassicheskiy/"
//                },
//                new Entry
//                {
//                    ID = 4811485017546, Name = "Сыр Danke сливочный",
//                    Link = "https://otzovik.com/reviews/sir_danke_slivochniy/"
//                },
//};



//            modelBuilder.Entity<Entry>().HasData(review);

//            base.OnModelCreating(modelBuilder);
//        }
        #endregion

    }
}